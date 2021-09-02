import 'package:flutter/widgets.dart';
import 'package:layout_tools/src/export.dart';

typedef ResponsiveLayoutWidgetBuilder = Widget Function(
    BuildContext context, MaterialSizes size);

class ResponsiveLayoutBuilder extends StatefulWidget {
  final ResponsiveLayoutWidgetBuilder builder;
  ResponsiveLayoutBuilder({required this.builder});

  @override
  State<StatefulWidget> createState() => _ResponsiveLayoutBuilderState();
}

class _ResponsiveLayoutBuilderState extends State<ResponsiveLayoutBuilder> {
  MaterialSizes? _size;
  InheritedWidget? _scope;
  DeviceType? _type;

  @override
  void didChangeDependencies() {
    final _scope = LayoutScope.of(context);
    assert(_scope != null,
        'Cannot find LayoutScope widget in widget tree.\nTo fix it, add LayoutScope widget to the root fo your widget tree');
    if (_scope != null) {
      _type = _scope.deviceType;
      _size = _scope.materialSize;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _size!);
}
