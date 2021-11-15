import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './AdminAuthForm.dart';

import '../Routes/Routes.dart';

class AdminAuthentication extends StatefulWidget {
  @override
  State<AdminAuthentication> createState() => _AdminAuthenticationState();
}

class _AdminAuthenticationState extends State<AdminAuthentication> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _showError(BuildContext ctx, String? msg) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    if (msg != null)
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
  }

  Future<void> _submitAuthForm(
    String canteenName,
    String password,
    String contact,
    bool isLogin,
    BuildContext ctx,
  ) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential authResult;
    final String email = canteenName + "@canteen.com";

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('canteens')
            .doc(authResult.user!.uid)
            .collection('profile')
            .add({
          'name': canteenName,
          'contact': contact,
        });
      }
      _showError(ctx, null);
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.adminScreen,
        (route) => false,
      );
    } on FirebaseException catch (err) {
      var msg = "An error occurred. Please check your credentials!";

      if (err.message != null) {
        msg = err.message!;
        if (err.code == "email-already-in-use") {
          msg = "This email is already registered. Try to login.";
        } else if (err.code == "user-not-found") {
          msg = "Email is not registered. First register then login.";
        } else if (err.code == "wrong-password") {
          msg = "Password is incorrect.";
        } else if (err.code == "invalid-email") {
          msg = "Email is incorrect.";
        }
      }
      _showError(ctx, msg);
    }

    setState(() {
      _isLoading = false;
    });
  }

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
                AdminAuthForm(_submitAuthForm, _isLoading),
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
