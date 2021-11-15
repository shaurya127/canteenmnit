import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;

  AuthForm(this.submitAuthForm);

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

  final GlobalKey<FormState> _formKey = GlobalKey();

  //Functions
  Future<void> submitForm() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!_formKey.currentState!.validate()) {
      //Invalid!
      return;
    }

    _formKey.currentState!.save();
    //Here goes the signup logic
    widget.submitAuthForm(userName, userContact, userEmail, userPassword,
        userHostelName, userRoomNo, false, context);
    // _formKey.currentState!.reset();

    return;
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 5),
            child: TextFormField(
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
            child: TextFormField(
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
            child: TextFormField(
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
