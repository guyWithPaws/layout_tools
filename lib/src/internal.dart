import 'package:meta/meta.dart';

/// Types of devices provided by Material Design:
/// 1. Handset (mobile)
/// 2. Tablet
/// 3. Desktop
enum DeviceType {
  handset,
  tablet,
  desktop,
}

/// A base class describes different types of screens according to Material Design Guidance
@immutable
class MaterialSizes {
  final num maxWidth;
  final num minWidth;

  @literal
  const MaterialSizes._(
    this.minWidth,
    this.maxWidth,
  );

  static const MaterialSizes xsmall = MaterialSizes._(0, 599);
  static const MaterialSizes small = MaterialSizes._(600, 959);
  static const MaterialSizes medium = MaterialSizes._(960, 1279);
  static const MaterialSizes large = MaterialSizes._(1280, 1919);
  static const MaterialSizes xlarge = MaterialSizes._(1920, double.infinity);

  T when<T>({
    required T Function() xsmall,
    required T Function() small,
    required T Function() medium,
    required T Function() large,
    required T Function() xlarge,
  }) {
    switch (this.maxWidth) {
      case 599:
        return xsmall();
      case 959:
        return small();
      case 1279:
        return medium();
      case 1919:
        return large();
      default:
        return xlarge();
    }
  }

  T maybeWhen<T extends Object?>({
    T Function()? xsmall,
    T Function()? small,
    T Function()? medium,
    T Function()? large,
    T Function()? xlarge,
    required T Function() orElse,
  }) {
    switch (this.minWidth) {
      case 599:
        return xsmall?.call() ?? orElse();
      case 959:
        return small?.call() ?? orElse();
      case 1279:
        return medium?.call() ?? orElse();
      case 1919:
        return large?.call() ?? orElse();
      default:
        return xlarge?.call() ?? orElse();
    }
  }

  @override
  int get hashCode => '$maxWidth$minWidth'.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is num) {
      return minWidth >= other || maxWidth >= other;
    } else if (other is MaterialSizes) {
      return other.minWidth == minWidth && other.maxWidth == maxWidth;
    } else {
      return false;
    }
  }

  @override
  String toString() =>
      'MaterialSize: minWidth - $minWidth, maxWidth - $maxWidth';
}
