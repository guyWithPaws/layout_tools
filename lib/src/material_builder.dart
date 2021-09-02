import 'package:flutter/widgets.dart';
import 'package:layout_tools/src/export.dart';

typedef ResponsiveLayoutWidgetBuilder = Widget Function(
    BuildContext context, MaterialSizes size);


/// Buider, which delegates  
class ResponsiveLayoutBuilder extends StatefulWidget {
  final ResponsiveLayoutWidgetBuilder builder;
  ResponsiveLayoutBuilder({required this.builder});

  static LayoutScopeInherited? of(BuildContext context, {bool listen = true}) =>
      LayoutScope.of(context, listen: listen);

  @override
  State<StatefulWidget> createState() => _ResponsiveLayoutBuilderState();
}

class _ResponsiveLayoutBuilderState extends State<ResponsiveLayoutBuilder> {
  MaterialSizes? _size;
  InheritedWidget? _scope;

  @override
  void didChangeDependencies() {
    final _scope = LayoutScope.of(context);
    if (_scope != null) {
      _size = _scope.materialSize;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_scope != null) {
      return widget.builder(context, _size!);
    } else {
      return LayoutScope(
        child: Builder(
          builder: (innerContext) => widget.builder(
              innerContext, LayoutScope.of(innerContext)!.materialSize),
        ),
      );
    }
  }
}
