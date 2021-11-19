import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dummy_data.dart';

class AdminAuthForm extends StatefulWidget {
  final Function submitAuthForm;
  final bool isLoading;

  AdminAuthForm(this.submitAuthForm, this.isLoading);

  @override
  _AdminAuthFormState createState() => _AdminAuthFormState();
}

class _AdminAuthFormState extends State<AdminAuthForm> {
  String userCanteenName = '';
  String userPassword = '';
  String userContact = '';
  bool isLogin = true;

  final GlobalKey<FormState> _formKey = GlobalKey();

  //Functions
  Future<void> submitForm() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.submitAuthForm(
        userCanteenName,
        userPassword,
        userContact,
        isLogin,
        context,
      );
      return;
    }
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
                hintText: 'Enter Canteen Name',
                hintStyle: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w300,
                ),
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              key: ValueKey("name"),
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
              key: ValueKey("password"),
              obscureText: true,
              style: TextStyle(color: Colors.pink[900]),
              validator: (valueEnteredByUser) {
                if (valueEnteredByUser!.isEmpty &&
                    valueEnteredByUser.length <= 2) {
                  return 'Invalid password!';
                } else {
                  return null;
                }
              },
              onSaved: (valueEnteredByUser) {
                userPassword = valueEnteredByUser!;
              },
            ),
          ),
          if (!isLogin)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Contact No',
                  hintStyle: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.number,
                key: ValueKey("contact"),
                style: TextStyle(color: Colors.pink[900]),
                validator: (valueEnteredByUser) {
                  if (valueEnteredByUser!.isEmpty &&
                      valueEnteredByUser.length <= 2) {
                    return 'Invalid contact!';
                  } else {
                    return null;
                  }
                },
                onSaved: (valueEnteredByUser) {
                  userContact = valueEnteredByUser!;
                },
              ),
            ),
          FlatButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(isLogin ? "Register new canteen" : "Login Instead"),
          ),
          SizedBox(
            height: 10,
          ),
          widget.isLoading
              ? CircularProgressIndicator()
              : ButtonTheme(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
