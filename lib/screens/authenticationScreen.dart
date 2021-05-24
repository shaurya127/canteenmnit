import 'package:canteenmnit/screens/homeScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/authScreenForm.dart';

class AuthenticationScreen extends StatelessWidget {
  final titleOfApp;

  AuthenticationScreen(this.titleOfApp);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(

        // appBar: AppBar(
        //     title: Text(
        //       titleOfApp,
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     backgroundColor: Colors.blue[900],
        //     brightness: Brightness.dark),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            color: Colors.blue[50],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Image.asset('assets/images/Canteenmnit-logo.jpg'),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Please Enter Details',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Student Side',
                      style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                    ),
                  ),
                  Column(children: [
                    AuthScreenForm(),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          HomeScreen.routeName,
                        );
                      },
                      label: Text(
                        'Skip',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      icon: Icon(Icons.arrow_forward_rounded),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
