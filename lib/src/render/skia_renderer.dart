import '../layout/yoga_node.dart';
import '../reconciler/reconciler.dart';

/// Command recorded for direct Skia / Canvas rendering pipeline.
class SkiaDrawCommand {
  final String commandType; // 'drawRect', 'drawText', 'drawImage'
  final LayoutRect rect;
  final Map<String, dynamic> paintProps;

  SkiaDrawCommand({
    required this.commandType,
    required this.rect,
    required this.paintProps,
  });

  @override
  String toString() => 'SkiaDrawCommand($commandType at $rect with $paintProps)';
}

/// Optional Direct Skia Rendering Engine inspired by DartNative direct canvas rendering.
/// Provides direct-to-Skia surface rendering bypassing platform native views when enabled.
class SkiaRenderer {
  final List<SkiaDrawCommand> _drawCommands = [];

  List<SkiaDrawCommand> get recordedCommands => List.unmodifiable(_drawCommands);

  void renderFromPatches(List<RenderPatch> patches) {
    _drawCommands.clear();
    for (final patch in patches) {
      if (patch.type == PatchType.create || patch.type == PatchType.update) {
        final layout = patch.layout;
        if (layout == null) continue;

        if (patch.componentType == 'View' || patch.componentType == 'Button') {
          _drawCommands.add(SkiaDrawCommand(
            commandType: 'drawRect',
            rect: layout,
            paintProps: {
              'color': patch.props?['backgroundColor'] ?? '#FFFFFF',
            },
          ));
        } else if (patch.componentType == 'Text') {
          _drawCommands.add(SkiaDrawCommand(
            commandType: 'drawText',
            rect: layout,
            paintProps: {
              'text': patch.props?['content'] ?? '',
              'fontSize': patch.props?['fontSize'] ?? 14.0,
              'color': patch.props?['color'] ?? '#000000',
            },
          ));
        } else if (patch.componentType == 'Image') {
          _drawCommands.add(SkiaDrawCommand(
            commandType: 'drawImage',
            rect: layout,
            paintProps: {
              'source': patch.props?['source'] ?? '',
              'fit': patch.props?['fit'] ?? 'cover',
            },
          ));
        }
      }
    }
  }

  void reset() {
    _drawCommands.clear();
  }
}
