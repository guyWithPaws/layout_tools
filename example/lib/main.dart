import 'package:flutter/material.dart';
import 'package:layout_tools/layout_tools.dart';

void main() => runApp(
      LayoutScope(child: MyApp()),
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
            if (size == MaterialSizes.xsmall) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ColoredBox(
                      color: Colors.green,
                    ),
                  ),
                ),
                itemCount: 100,
              );
            } else if (size == MaterialSizes.small) {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ColoredBox(
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            } else if (size == MaterialSizes.medium) {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ColoredBox(
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ColoredBox(
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
