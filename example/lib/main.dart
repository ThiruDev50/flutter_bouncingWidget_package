import 'package:flutter/material.dart';
import 'package:tdk_bouncingwidget/tdk_bouncingwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Bouncing widget Demo',
      home: MyHomePage(title: 'Bouncing widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Bouncing Wiget only Bouncing IN
              BouncingWidgetInOut(
                onPressed: () {},
                bouncingType: BouncingType.bounceInOnly,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 200,
                    child: const Card(
                      color: Colors.red,
                      child: Center(
                          child: Text("Bouncing In only",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
              ),

              // Bouncing Wiget only Bouncing OUT
              BouncingWidgetInOut(
                onPressed: () {},
                bouncingType: BouncingType.bounceOutOnly,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 200,
                    child: const Card(
                      color: Colors.blue,
                      child: Center(
                          child: Text("Bouncing out only",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
              ),

              // Bouncing Wiget  Bouncing both IN and OUT
              BouncingWidgetInOut(
                onPressed: () {},
                bouncingType: BouncingType.bounceInAndOut,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 200,
                    child: const Card(
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "Bouncing In and out",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
