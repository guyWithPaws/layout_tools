import 'package:flutter/material.dart';
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
  const MaterialSizes._(
    this.minWidth,
    this.maxWidth,
  );

  static const MaterialSizes xsmall = MaterialSizes._(0, 599);
  static const MaterialSizes small = MaterialSizes._(600, 959);
  static const MaterialSizes medium = MaterialSizes._(960, 1279);
  static const MaterialSizes large = MaterialSizes._(1280, 1919);
  static const MaterialSizes xlarge = MaterialSizes._(1920, double.infinity);

  @override
  int get hashCode => '$maxWidth$minWidth'.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is num) {
      return minWidth >= other || maxWidth <= other;
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
