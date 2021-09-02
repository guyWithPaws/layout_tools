import 'package:flutter/material.dart';
import 'package:layout_tools/layout_tools.dart';

void main() => runApp(
       MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveLayoutBuilder(
          builder: (context, size) {
            if (size == MaterialSizes.large) {
              return Text('MaterialSizes.large');
            } else {
              return Text(
                MaterialSizes.small.toString(),
              );
            }
          },
        ),
      ),
    );
  }
}
