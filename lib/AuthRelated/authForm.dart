import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;
  final bool isLoading;

  AuthForm(this.submitAuthForm, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //Here managed all the entries entered by user
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userContact = '';
  String userHostelName = '';
  String userRoomNo = '';

  bool isLogin = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  //Functions
  Future<void> submitForm() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!_formKey.currentState!.validate()) {
      //Invalid!
      return;
    }

    _formKey.currentState!.save();
    widget.submitAuthForm(
      userName,
      userContact,
      userEmail,
      userPassword,
      userHostelName,
      userRoomNo,
      isLogin,
      context,
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (!isLogin) ...[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 5),
              child: TextFormField(
                key: ValueKey("Name"),
                decoration: InputDecoration.collapsed(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
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
                  userName = valueEnteredByUser!;
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
                key: ValueKey("Contact"),
                decoration: InputDecoration.collapsed(
                  hintText: 'Contact No.',
                  hintStyle: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.pink[900]),
                validator: (valueEnteredByUser) {
                  if (valueEnteredByUser!.isEmpty &&
                      valueEnteredByUser.length <= 2) {
                    return 'Invalid contact no!';
                  } else {
                    return null;
                  }
                },
                onSaved: (valueEnteredByUser) {
                  userContact = valueEnteredByUser!;
                },
              ),
            ),
          ],
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
            child: TextFormField(
              key: ValueKey("Email"),
              decoration: InputDecoration.collapsed(
                hintText: 'College Email Id',
                hintStyle: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w300,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.pink[900]),
              validator: (valueEnteredByUser) {
                if (valueEnteredByUser!.isEmpty &&
                    valueEnteredByUser.length <= 2) {
                  return 'Invalid email!';
                } else {
                  return null;
                }
              },
              onSaved: (valueEnteredByUser) {
                userEmail = valueEnteredByUser!;
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
              key: ValueKey("Password"),
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w300,
                ),
              ),
              keyboardType: TextInputType.text,
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
          if (!isLogin) ...[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
              child: TextFormField(
                key: ValueKey("Hostel"),
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter Hostel Name',
                  hintStyle: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(color: Colors.pink[900]),
                validator: (valueEnteredByUser) {
                  if (valueEnteredByUser!.isEmpty &&
                      valueEnteredByUser.length <= 2) {
                    return 'Invalid hostel!';
                  } else {
                    return null;
                  }
                },
                onSaved: (valueEnteredByUser) {
                  userHostelName = valueEnteredByUser!;
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
                key: ValueKey("Room"),
                decoration: InputDecoration.collapsed(
                  hintText: 'Room No.',
                  hintStyle: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(color: Colors.pink[900]),
                validator: (valueEnteredByUser) {
                  if (valueEnteredByUser!.isEmpty &&
                      valueEnteredByUser.length <= 2) {
                    return 'Invalid room!';
                  } else {
                    return null;
                  }
                },
                onSaved: (valueEnteredByUser) {
                  userRoomNo = valueEnteredByUser!;
                },
              ),
            ),
          ],
          FlatButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(isLogin ? "Create new account" : "Login Instead"),
          ),
          SizedBox(
            height: 10,
          ),
          !widget.isLoading
              ? ButtonTheme(
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
                )
              : CircularProgressIndicator()
        ],
      ),
    );
  }
}
