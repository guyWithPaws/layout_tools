import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:layout_tools/layout_tools.dart';

typedef LayoutScopeInherited = _LayoutScopeInherited;

// ignore_for_file: unrelated_type_equality_checks

/// A Widget for accessing a current
/// layout information.
///
/// Use an [of] method to access a full Inherited Widget.
/// For more detailed info use:
///
/// * [sizeOf] to get currnet [MaterialSizes]
/// * [deviceTypeOf] to get [DeviceType]
class LayoutScope extends StatefulWidget {
  final Widget child;
  const LayoutScope({required this.child, Key? key}) : super(key: key);

  /// The data from the closest instance of this class that encloses the given context.
  ///
  /// Notice, that ResponsiveBuilders create new instance of [LayoutScope] above them
  /// if they cannot find closest instance  in the widget tree
  static LayoutScopeInherited? of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final widget =
          context.dependOnInheritedWidgetOfExactType<_LayoutScopeInherited>();
      return widget;
    } else {
      final element = context
          .getElementForInheritedWidgetOfExactType<_LayoutScopeInherited>();
      return element?.widget as _LayoutScopeInherited?;
    }
  }

  /// Invokes [of] method and returns current MaterialSize
  static MaterialSizes? sizeOf(BuildContext context, {bool listen = true}) =>
      of(context, listen: listen)?.materialSize;

  /// Invokes [of] method and returns device type
  static DeviceType? deviceTypeOf(BuildContext context, {bool listen = true}) =>
      of(context, listen: listen)?.deviceType;

  @override
  _LayoutScopeState createState() => _LayoutScopeState();
}

/// Note for advanced developers:
///
/// [setState] in [didChangeMetrics] does not do any work
/// because another setState is calling by MediaQuery Inherited Widget.
///
/// For more info see [WidgetsApp] and [_MediaQueryFromWindow].
///
/// So you do not have to think about performance seeing [setState] in [didChangeMetrics]
// ignore: prefer_mixin
class _LayoutScopeState extends State<LayoutScope> with WidgetsBindingObserver {

  MediaQueryData? _mediaQueryData;

  @override
  void didChangeMetrics() {
    setState(() {
      _mediaQueryData = MediaQueryData.fromWindow(window);
    });
    super.didChangeMetrics();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _mediaQueryData ??= MediaQueryData.fromWindow(window);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => _LayoutScopeInherited(
        mediaQueryData: _mediaQueryData!,
        child: widget.child,
      );
}

class _LayoutScopeInherited extends InheritedWidget {
  const _LayoutScopeInherited({
    required Widget child,
    required this.mediaQueryData,
  }) : super(child: child);
  final MediaQueryData mediaQueryData;

// Orientation get _orientation => mediaQueryData.orientation;

  num get _logicalWidth => mediaQueryData.size.width;

  /// Returns device type according to screen logical width
  DeviceType get deviceType {
    if (_logicalWidth < 600) {
      return DeviceType.handset;
    } else if (_logicalWidth > 600 && _logicalWidth < 1280) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Returns [MaterialSizes] according to screen logical width
  ///
  /// For more info see [MaterialSizes] class
  MaterialSizes get materialSize {
    if (MaterialSizes.xsmall == _logicalWidth) {
      return MaterialSizes.xsmall;
    } else if (MaterialSizes.small == _logicalWidth) {
      return MaterialSizes.small;
    } else if (MaterialSizes.medium == _logicalWidth) {
      return MaterialSizes.medium;
    } else if (MaterialSizes.large == _logicalWidth) {
      return MaterialSizes.large;
    } else {
      return MaterialSizes.xlarge;
    }
  }

  @override
  bool updateShouldNotify(covariant _LayoutScopeInherited oldWidget) =>
      !identical(this, oldWidget) && mediaQueryData != oldWidget.mediaQueryData;
}
