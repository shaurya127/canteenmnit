import 'package:flutter/material.dart';

import '../widgets/authScreenForm.dart';

import '../Routes/Routes.dart';

class SelectAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget getCont(String txt, String type) {
      return GestureDetector(
        // onTap: () => {Navigator.pushNamed(context, Routes.mainLogin)},
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 5),
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    }

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
                  'You are...',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Column(children: [
                Column(
                  children: <Widget>[
                    getCont("MNIT Student", "Student"),
                    getCont("MNIT Professor", "Professor"),
                    getCont("Outside MNIT", "Student"),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    ));
  }
}
