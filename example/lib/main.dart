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
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
}

// This call to setState tells the Flutter framework that something has
// changed in this State, which causes it to rerun the build method below
// so that the display can reflect the updated values. If we changed
// _counter without calling setState(), then the build method would not be
// called again, and so nothing would appear to happen.
class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// This method is rerun every time setState is called, for instance as done
    return Scaffold(
        appBar: AppBar(
          /// Here we take the value from the MyHomePage object that was created by
          title: Text(widget.title),
        ),
        body: Center(
          /// Center is a layout widget. It takes a single child and positions it
          child: Column(
            /// Column is also a layout widget. It takes a list of children and
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Bouncing Wiget only Bouncing IN
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

              /// Bouncing Wiget only Bouncing OUT
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

              /// Bouncing Wiget  Bouncing both IN and OUT
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
