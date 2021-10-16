import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/onboardingnewuser.dart';
import 'CanteenRelated/screens/particularCanteenOverview.dart';

import './Routes/Routes.dart';
import './AdminRelated/authentication.dart';
import './AdminRelated/admin_screen.dart';
import 'AuthRelated/mainAuth.dart';
import 'AuthRelated/mainDetails.dart';
import 'AuthRelated/selectType.dart';
import './screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Theme.of(context).errorColor,
        ),
      ),
      home: MyHomePage(
        titleOfApp:
            'Canteen MNIT', //From here you can change the title of the app
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.boardingPage: (ctx) => onboarding(),
        Routes.adminLogin: (ctx) => AdminAuthentication(),
        Routes.adminScreen: (ctx) => AdminScreen(),
        Routes.selectAuth: (ctx) => SelectAuth(),
        Routes.mainAuth: (ctx) => MainAuth(),
        Routes.mainDetails: (ctx) => MainDetail(),
        Routes.homeScreen: (ctx) => HomeScreen(),
        Routes.canteenDetail: (ctx) => ParticularCanteenOverview(),
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
      () => Navigator.pushReplacementNamed(context, Routes.boardingPage),
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
