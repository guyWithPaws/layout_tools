import 'package:flutter/foundation.dart';

class LayoutScopeNotFoundException implements Exception {
  final Type widget;
  LayoutScopeNotFoundException({required this.widget});
  @override
  String toString() => '''
  Error: Could not find the correct LayoutScope above this $widget Widget
  
  ''';
}
