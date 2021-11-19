import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddDish extends StatefulWidget {
  final String uid;

  const AddDish({required this.uid});

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _name = "";
  String _price = "";
  String _desc = "";

  File? imgChosen;

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
      final doc = FirebaseFirestore.instance
          .collection('canteens/${widget.uid}/dishes')
          .doc();
      final ref = FirebaseStorage.instance;
      var url;
      if (imgChosen != null) {
        List<String> l1 = imgChosen!.path.split(".");
        final refImg = ref
            .ref()
            .child('user_images')
            .child(doc.id + '.${l1[l1.length - 1]}');
        await refImg.putFile(imgChosen!);
        url = await refImg.getDownloadURL();
      }
      await doc.set({
        'name': _name,
        'price': _price,
        'description': _desc,
        'imgUrl': url
      });
      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Added succesfully"),
          backgroundColor: Colors.green,
        ),
      );
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

  void _pickImg(int choice) async {
    final ImagePicker _picker = ImagePicker();
    final pickedImgFile = await _picker.pickImage(
      source: choice == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      if (pickedImgFile != null) {
        imgChosen = File(pickedImgFile.path);
      }
    });
  }

  void _chooseOptionToPick() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.camera_alt, size: 40),
              onPressed: () {
                Navigator.of(ctx).pop();
                _pickImg(1);
              },
              label: Text("Camera"),
              textColor: Theme.of(context).accentColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.photo, size: 40),
              onPressed: () {
                Navigator.of(ctx).pop();
                _pickImg(2);
              },
              label: Text("Gallery"),
              textColor: Theme.of(context).accentColor,
            ),
          ],
        ),
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
              GestureDetector(
                onTap: _chooseOptionToPick,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Image"),
                      // Text(imgChosen == null ? "" : imgChosen!.path),
                    ],
                  ),
                ),
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
