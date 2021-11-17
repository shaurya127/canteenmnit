import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddDish extends StatefulWidget {
  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _img = "";
  String _name = "";
  String _price = "";
  String _desc = "";

  String? _validateImg(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String? _validateName(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String? _validatePrice(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String? _validateDesc(String val) {
    // if (val.isEmpty) {
    //   return "This field is required.";
    // }
    return null;
  }

  Future<void> _submitForm() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('dishes').add({
        'img': _img,
        'name': _name,
        'price': _price,
        'description': _desc,
      });
      print({
        'img': _img,
        'name': _name,
        'price': _price,
        'description': _desc,
      });
      _formKey.currentState!.reset();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Container getFormInput(
    String hintText,
    TextInputType inputType,
    Function validator,
    Function onSaved, {
    TextCapitalization txtCapitalization: TextCapitalization.none,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.w300,
          ),
        ),
        keyboardType: inputType,
        textCapitalization: txtCapitalization,
        style: TextStyle(color: Colors.pink[900]),
        validator: (val) => validator(val),
        onSaved: (val) => onSaved(val),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              getFormInput(
                "Image URL",
                TextInputType.url,
                _validateImg,
                (val) => {_img = val},
              ),
              getFormInput(
                "Name of Dish",
                TextInputType.name,
                _validateName,
                (val) => {_name = val},
                txtCapitalization: TextCapitalization.words,
              ),
              getFormInput(
                "Price (in Rs)",
                TextInputType.number,
                _validatePrice,
                (val) => {_price = val},
              ),
              getFormInput(
                "Description",
                TextInputType.text,
                _validateDesc,
                (val) => {_desc = val},
                txtCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : ButtonTheme(
                      // minWidth: deviceSize.width * 0.85,
                      buttonColor: Colors.blue[900],
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textColor: Colors.white,
                        onPressed: _submitForm,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
