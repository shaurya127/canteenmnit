import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../Routes/Routes.dart';
import 'authForm.dart';

class MainAuth extends StatefulWidget {
  @override
  _MainAuthState createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
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
    String name,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential authResult;

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
            .collection('users')
            .doc(authResult.user!.uid)
            .collection('profile')
            .add({
          'name': name,
          'email': email,
        });
      }
      _showError(ctx, null);
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.mainDetails,
        (route) => false,
      );
    } on PlatformException catch (err) {
      var msg = "An error occurred. Please check your credentials!";

      if (err.message != null) {
        msg = err.message!;
        if (err.code == "ERROR_EMAIL_ALREADY_IN_USE") {
          msg = "This email is already registered. Try to login.";
        } else if (err.code == "ERROR_USER_NOT_FOUND") {
          msg = "Email is not registered. First register then login.";
        }
      }
      _showError(ctx, msg);
    } catch (err) {
      _showError(ctx, "Internal Server Error");
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
                    'Student Side',
                    style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                  ),
                ),
                Column(children: [
                  AuthForm(),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        (route) => false,
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
      ),
    );
  }
}
