import 'package:flutter/material.dart';

import '../AuthRelated/mainDetails.dart';

class MainScreen extends StatelessWidget {
  final titleOfApp;

  MainScreen({this.titleOfApp});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MainDetail(),
    );
  }
}
