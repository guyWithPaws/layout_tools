import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:layout_tools/layout_tools.dart';


/// A Widget for accessing a current
/// layout information. 
/// 
/// Use an [of] method to access a full Inherited Widget.
/// For more detailed info use:
/// 
/// * [sizeOf] to get current height and width
/// * [deviceTypeOf] to get [DeviceType]
class LayoutScope extends StatefulWidget {
  final Widget child;
  const LayoutScope({required this.child, Key? key}) : super(key: key);

  static _LayoutScopeInherited? of(BuildContext context, {bool listen = true}) {
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

  static Size? sizeOf(BuildContext context, {bool listen = true}) => of(context, listen: listen)?.mediaQueryData.size;

  static DeviceType? deviceTypeOf(BuildContext context, {bool listen = true}) => of(context, listen: listen)?.deviceType;

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

  MediaQueryData? _mediaQueryData;

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
  const _LayoutScopeInherited(
      {required Widget child, required this.mediaQueryData})
      : super(child: child);
  final MediaQueryData mediaQueryData;

// Orientation get _orientation => mediaQueryData.orientation;

  num get _logicalWidthFromPhysical => mediaQueryData.size.width;

  DeviceType get deviceType {
    if (_logicalWidthFromPhysical < 600) {
      return DeviceType.handset;
    } else if (_logicalWidthFromPhysical > 600 && _logicalWidthFromPhysical < 1280) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  @override
  bool updateShouldNotify(covariant _LayoutScopeInherited oldWidget) =>
      !identical(this, oldWidget) && mediaQueryData != oldWidget.mediaQueryData;
}