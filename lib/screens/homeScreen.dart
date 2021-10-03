import 'package:flutter/material.dart';

import '../widgets/bottombar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final titleOfApp;
  HomeScreen({this.titleOfApp});

  @override
  Widget build(BuildContext context) {
    //Here is the main home screen of the app
    return Scaffold(
      extendBody: true, // very important as noted
      // bottomNavigationBar: NavigationBar(),
      backgroundColor: Colors.blue[50],
      body: NavigationBar(),
    );
  }
}
