/*
Login Credentials:

1. User
    2020UCP1801@mnit.ac.in
    saksham

2. Admin
    Annapurna
    annapurna
*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mnit_canteen_app/widgets/authScreenForm.dart';

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

String startScreen = Routes.boardingPage;

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
          actionsIconTheme: IconThemeData(
            color: Colors.white,
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            startScreen = Routes.boardingPage;
          }
          if (snap.hasData) {
            final user = FirebaseAuth.instance.currentUser!.uid;
            final cl = FirebaseFirestore.instance
                .collection("users")
                .doc(user)
                .get()
                .then((value) {
              if (value.exists)
                startScreen = Routes.homeScreen;
              else
                startScreen = Routes.adminScreen;
            });
          }
          return MyHomePage();
        },
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
      () => Navigator.pushReplacementNamed(context, startScreen),
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
