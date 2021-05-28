import 'dart:async';
import 'package:flutter/material.dart';
import './screens/mainScreen.dart';
import './screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen MNIT',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(
        titleOfApp:
            'Canteen MNIT', //From here you can change the title of the app
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(
              titleOfApp:
                  'Canteen MNIT', //Here optimization is required to avoid the name clash when we add furthur routes
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final titleOfApp;
  final icon;
  final label;

  MyHomePage({this.titleOfApp, this.icon, this.label});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            titleOfApp: widget.titleOfApp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Canteenmnit.jpg'),
          ),
        ),
      ),
    );
  }
}
