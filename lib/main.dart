import 'dart:async';

import 'package:flutter/material.dart';

import './screens/onboardingnewuser.dart';
import './screens/mainScreen.dart';
import './screens/homeScreen.dart';
import 'CanteenRelated/screens/particularCanteenOverview.dart';

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
        appBarTheme: AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        scaffoldBackgroundColor: Colors.cyan[50],
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
        ParticularCanteenOverview.routeName: (ctx) =>
            ParticularCanteenOverview()
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
        MaterialPageRoute(builder: (context) => onboarding()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          image: AssetImage('assets/images/Canteenmnit.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
