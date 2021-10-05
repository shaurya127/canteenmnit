import 'package:flutter/material.dart';

import './AdminAuthForm.dart';

import '../Routes/Routes.dart';

class AdminAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
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
                margin: EdgeInsets.only(top: 80, bottom: 20),
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
                  'Admin Side',
                  style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                ),
              ),
              Column(children: [
                AdminAuthForm(),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.adminScreen);
                  },
                  label: Text(
                    'Skip',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
