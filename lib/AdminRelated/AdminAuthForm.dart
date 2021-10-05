import 'package:flutter/material.dart';

import '../dummy_data.dart';

class AdminAuthForm extends StatefulWidget {
  @override
  _AdminAuthFormState createState() => _AdminAuthFormState();
}

class _AdminAuthFormState extends State<AdminAuthForm> {
  String userCanteenName = '';
  String userPassword = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  //Functions
  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //Here goes the signup logic
      //We can show any error occured here by pointing to _showErrorDialog
      return;
    }
  }

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctxDialog) {
          return AlertDialog(
            title: Text('An Error Occured!'),
            content: Text(message),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctxDialog).pop();
                  },
                  child: Text('Back'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                hintText: 'Choose Canteen Name',
                hintStyle: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w300,
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.pink[900]),
              validator: (valueEnteredByUser) {
                if (valueEnteredByUser!.isEmpty &&
                    valueEnteredByUser.length <= 2) {
                  return 'Invalid name!';
                } else {
                  return null;
                }
              },
              onSaved: (valueEnteredByUser) {
                userCanteenName = valueEnteredByUser!;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w300,
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.pink[900]),
              validator: (valueEnteredByUser) {
                if (valueEnteredByUser!.isEmpty &&
                    valueEnteredByUser.length <= 2) {
                  return 'Invalid name!';
                } else {
                  return null;
                }
              },
              onSaved: (valueEnteredByUser) {
                userPassword = valueEnteredByUser!;
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ButtonTheme(
            minWidth: deviceSize.width * 0.85,
            buttonColor: Colors.blue[900],
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textColor: Colors.white,
              onPressed: submitForm,
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
