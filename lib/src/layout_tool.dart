import 'dart:ui';


class LayoutTool {
  const LayoutTool._();

  // ignore: prefer_constructors_over_static_methods
  static const instance = LayoutTool._();

  double get pixelRatioCoefficient => window.devicePixelRatio;

  double get logicalHeight => _size.height / pixelRatioCoefficient;

  double get logicalWidth => _size.width / pixelRatioCoefficient;

  Size get _size => window.physicalSize;

}
