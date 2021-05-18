import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final titleOfApp;
  HomeScreen({this.titleOfApp});

  @override
  Widget build(BuildContext context) {
    //Here is the main home screen of the app
    return Scaffold(
      appBar: AppBar(
        title: Text(titleOfApp),
      ),
      body: FutureBuilder(
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(child: Text("Home Screen"))),
    );
  }
}
