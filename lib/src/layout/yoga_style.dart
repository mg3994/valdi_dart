/// Flexbox Layout Enumerations and Style Properties for Yoga.

enum FlexDirection { row, column, rowReverse, columnReverse }

enum JustifyContent { flexStart, center, flexEnd, spaceBetween, spaceAround, spaceEvenly }

enum AlignItems { flexStart, center, flexEnd, stretch, baseline }

enum AlignSelf { auto, flexStart, center, flexEnd, stretch, baseline }

enum FlexWrap { noWrap, wrap, wrapReverse }

enum PositionType { relative, absolute }

class EdgeValues {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const EdgeValues({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  const EdgeValues.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const EdgeValues.symmetric({double vertical = 0.0, double horizontal = 0.0})
      : left = horizontal,
        right = horizontal,
        top = vertical,
        bottom = vertical;
}

class YogaStyle {
  FlexDirection flexDirection;
  JustifyContent justifyContent;
  AlignItems alignItems;
  AlignSelf alignSelf;
  FlexWrap flexWrap;
  PositionType positionType;

  double? width;
  double? height;
  double? minWidth;
  double? minHeight;
  double? maxWidth;
  double? maxHeight;

  double flexGrow;
  double flexShrink;
  double? flexBasis;

  EdgeValues margin;
  EdgeValues padding;
  EdgeValues border;
  EdgeValues position;

  YogaStyle({
    this.flexDirection = FlexDirection.column,
    this.justifyContent = JustifyContent.flexStart,
    this.alignItems = AlignItems.stretch,
    this.alignSelf = AlignSelf.auto,
    this.flexWrap = FlexWrap.noWrap,
    this.positionType = PositionType.relative,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.flexGrow = 0.0,
    this.flexShrink = 1.0,
    this.flexBasis,
    this.margin = const EdgeValues(),
    this.padding = const EdgeValues(),
    this.border = const EdgeValues(),
    this.position = const EdgeValues(),
  });
}
