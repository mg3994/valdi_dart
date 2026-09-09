import 'yoga_style.dart';

/// Computed Layout Rect for a Yoga Node.
class LayoutRect {
  final double left;
  final double top;
  final double width;
  final double height;

  const LayoutRect({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  @override
  String toString() => 'LayoutRect(left: $left, top: $top, width: $width, height: $height)';
}

/// A Node in the Yoga Flexbox Layout Tree.
class YogaNode {
  final YogaStyle style;
  final List<YogaNode> children = [];
  YogaNode? parent;

  LayoutRect layout = const LayoutRect(left: 0, top: 0, width: 0, height: 0);

  YogaNode({YogaStyle? style}) : style = style ?? YogaStyle();

  void addChild(YogaNode child) {
    child.parent = this;
    children.add(child);
  }

  void insertChild(int index, YogaNode child) {
    child.parent = this;
    children.insert(index, child);
  }

  void removeChild(YogaNode child) {
    if (children.remove(child)) {
      child.parent = null;
    }
  }

  void removeAllChildren() {
    for (final child in children) {
      child.parent = null;
    }
    children.clear();
  }

  /// Calculates the layout for this node and its children given parent constraints without mutating style sizes.
  void calculateLayout({double? parentWidth, double? parentHeight}) {
    final computedWidth = style.width ?? parentWidth ?? 0.0;
    final computedHeight = style.height ?? parentHeight ?? 0.0;

    final contentLeft = style.margin.left;
    final contentTop = style.margin.top;

    layout = LayoutRect(
      left: contentLeft,
      top: contentTop,
      width: computedWidth,
      height: computedHeight,
    );

    if (children.isEmpty) return;

    final isRow = style.flexDirection == FlexDirection.row || style.flexDirection == FlexDirection.rowReverse;
    final paddingX = style.padding.left + style.padding.right;
    final paddingY = style.padding.top + style.padding.bottom;
    final availableWidth = (computedWidth - paddingX).clamp(0.0, double.infinity);
    final availableHeight = (computedHeight - paddingY).clamp(0.0, double.infinity);

    final isReverse = style.flexDirection == FlexDirection.rowReverse || style.flexDirection == FlexDirection.columnReverse;
    final layoutChildren = isReverse ? children.reversed.toList() : List<YogaNode>.from(children);

    double totalFixedMain = 0.0;
    double totalFlexGrow = 0.0;

    for (final child in layoutChildren) {
      final childMain = isRow ? (child.style.width ?? 0.0) : (child.style.height ?? 0.0);
      totalFixedMain += childMain;
      totalFlexGrow += child.style.flexGrow;
    }

    final mainAvailable = isRow ? availableWidth : availableHeight;
    final remainingSpace = mainAvailable - totalFixedMain;

    double offsetMain = isRow ? style.padding.left : style.padding.top;

    if (totalFlexGrow == 0.0 && remainingSpace > 0) {
      switch (style.justifyContent) {
        case JustifyContent.center:
          offsetMain += remainingSpace / 2;
          break;
        case JustifyContent.flexEnd:
          offsetMain += remainingSpace;
          break;
        case JustifyContent.spaceBetween:
          break;
        case JustifyContent.spaceAround:
          offsetMain += remainingSpace / (layoutChildren.length * 2);
          break;
        case JustifyContent.spaceEvenly:
          offsetMain += remainingSpace / (layoutChildren.length + 1);
          break;
        case JustifyContent.flexStart:
        default:
          break;
      }
    }

    final gap = (style.justifyContent == JustifyContent.spaceBetween && layoutChildren.length > 1)
        ? (remainingSpace / (layoutChildren.length - 1))
        : (style.justifyContent == JustifyContent.spaceAround && layoutChildren.length > 0)
            ? (remainingSpace / layoutChildren.length)
            : (style.justifyContent == JustifyContent.spaceEvenly && layoutChildren.length > 0)
                ? (remainingSpace / (layoutChildren.length + 1))
                : 0.0;

    for (int i = 0; i < layoutChildren.length; i++) {
      final child = layoutChildren[i];

      double childWidth = child.style.width ?? (isRow ? 0.0 : availableWidth);
      double childHeight = child.style.height ?? (isRow ? availableHeight : 0.0);

      if (totalFlexGrow > 0 && remainingSpace > 0 && child.style.flexGrow > 0) {
        final flexShare = (child.style.flexGrow / totalFlexGrow) * remainingSpace;
        if (isRow) {
          childWidth += flexShare;
        } else {
          childHeight += flexShare;
        }
      }

      double crossOffset = isRow ? style.padding.top : style.padding.left;
      final crossAvailable = isRow ? availableHeight : availableWidth;
      final childCrossSize = isRow ? childHeight : childWidth;

      final align = child.style.alignSelf != AlignSelf.auto
          ? child.style.alignSelf
          : _alignFromItems(style.alignItems);

      switch (align) {
        case AlignSelf.center:
          crossOffset += (crossAvailable - childCrossSize) / 2;
          break;
        case AlignSelf.flexEnd:
          crossOffset += crossAvailable - childCrossSize;
          break;
        case AlignSelf.stretch:
          if (isRow && child.style.height == null) childHeight = crossAvailable;
          if (!isRow && child.style.width == null) childWidth = crossAvailable;
          break;
        case AlignSelf.flexStart:
        default:
          break;
      }

      final childLeft = isRow ? offsetMain : crossOffset;
      final childTop = isRow ? crossOffset : offsetMain;

      child.calculateLayout(parentWidth: childWidth, parentHeight: childHeight);

      child.layout = LayoutRect(
        left: childLeft + child.style.margin.left,
        top: childTop + child.style.margin.top,
        width: childWidth,
        height: childHeight,
      );

      final mainSize = isRow ? childWidth : childHeight;
      offsetMain += mainSize + child.style.margin.left + child.style.margin.right;

      if (style.justifyContent == JustifyContent.spaceBetween) {
        offsetMain += gap;
      } else if (style.justifyContent == JustifyContent.spaceAround) {
        offsetMain += gap;
      } else if (style.justifyContent == JustifyContent.spaceEvenly) {
        offsetMain += gap;
      }
    }
  }

  AlignSelf _alignFromItems(AlignItems items) {
    switch (items) {
      case AlignItems.center:
        return AlignSelf.center;
      case AlignItems.flexEnd:
        return AlignSelf.flexEnd;
      case AlignItems.stretch:
        return AlignSelf.stretch;
      case AlignItems.baseline:
        return AlignSelf.baseline;
      case AlignItems.flexStart:
      default:
        return AlignSelf.flexStart;
    }
  }
}
