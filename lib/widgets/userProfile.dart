import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mnit_canteen_app/models/Loader.dart';
import 'package:mnit_canteen_app/models/getImage.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> userData;
  final bool admin;

  UserProfile({required this.uid, required this.userData, this.admin = false});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? imgChosen;

  String _name = "";
  String _contact = "";
  String _hostel = "";
  String _room = "";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Widget renderIconInField(deviceSize) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.02),
      child: SizedBox(
        height: 20,
        width: 20,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          backgroundColor: Colors.white,
          onPressed: _openPopup,
          child: Icon(
            Icons.edit,
            size: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _saveForm() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update({
      "contact": _contact,
      "name": _name,
      "hostelName": _hostel,
      "roomNo": _room,
    });
    Navigator.of(context).pop();
    setState(() {
      _isLoading = false;
    });
  }

  _openPopup() {
    _name = widget.userData["name"];
    _contact = widget.userData["contact"];
    _hostel = widget.userData["hostelName"];
    _room = widget.userData["roomNo"];
    return showModalBottomSheet(
      // title: Text("LOGIN"),
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: 500 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Name',
                  ),
                  initialValue: _name,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (valueEnteredByUser) {
                    if (valueEnteredByUser!.isEmpty &&
                        valueEnteredByUser.length <= 2) {
                      return 'Invalid name!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (valueEnteredByUser) {
                    _name = valueEnteredByUser!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact No',
                  ),
                  initialValue: _contact,
                  keyboardType: TextInputType.phone,
                  validator: (valueEnteredByUser) {
                    if (valueEnteredByUser!.isEmpty &&
                        valueEnteredByUser.length <= 2) {
                      return 'Invalid contact!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (valueEnteredByUser) {
                    _contact = valueEnteredByUser!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.home_filled),
                    labelText: 'Hostel Name',
                  ),
                  initialValue: _hostel,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (valueEnteredByUser) {
                    if (valueEnteredByUser!.isEmpty &&
                        valueEnteredByUser.length <= 2) {
                      return 'Invalid hostel name!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (valueEnteredByUser) {
                    _hostel = valueEnteredByUser!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.door_sliding_outlined),
                    labelText: 'Room No',
                  ),
                  initialValue: _room,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (valueEnteredByUser) {
                    if (valueEnteredByUser!.isEmpty &&
                        valueEnteredByUser.length <= 2) {
                      return 'Invalid room no!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (valueEnteredByUser) {
                    _room = valueEnteredByUser!;
                  },
                ),
                SizedBox(height: 10),
                _isLoading
                    ? Loader()
                    : ElevatedButton(
                        onPressed: _saveForm,
                        child: Text("Save"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldsInUserProfile(
      [String field = "",
      String userField = "",
      deviceSize,
      bool iconToBeIncluded = false]) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: deviceSize.height * 0.02,
          horizontal: deviceSize.width * 0.13),
      child: Row(children: [
        Text(field,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        Text(userField, style: TextStyle(fontSize: 18)),
        iconToBeIncluded && !widget.admin
            ? renderIconInField(deviceSize)
            : new Container(width: 0, height: 0)
      ]),
    );
  }

  void changeImg(File? image) async {
    final ref = FirebaseStorage.instance;
    var url;
    if (image != null) {
      List<String> l1 = image.path.split(".");
      final refImg = ref
          .ref()
          .child('user_images')
          .child(widget.uid + '.${l1[l1.length - 1]}');
      await refImg.putFile(image);
      url = await refImg.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection(widget.admin ? "canteens" : "users")
        .doc(widget.uid)
        .update({
      'imgUrl': url,
    });
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
        changeImg(imgChosen);
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
              textColor: Colors.blue[900],
            ),
            FlatButton.icon(
              icon: Icon(Icons.photo, size: 40),
              onPressed: () {
                Navigator.of(ctx).pop();
                _pickImg(2);
              },
              label: Text("Gallery"),
              textColor: Colors.blue[900],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Welcome, ${widget.userData["name"].toString().split(" ")[0]}",
              style: TextStyle(color: Colors.grey[800], fontSize: 25),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                Container(
                  height: deviceSize.height * 0.2,
                  width: deviceSize.width * 0.4,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: (Colors.grey[200])!,
                      width: 5.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: getImgUrl(
                      widget.userData["imgUrl"],
                      imgChosen,
                      widget.admin,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20, //give the values according to your requirement
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      onPressed: _chooseOptionToPick,
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: deviceSize.width,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                fieldsInUserProfile(
                  'Name- ',
                  widget.userData["name"],
                  deviceSize,
                  true,
                ),
                fieldsInUserProfile(
                  'Contact- ',
                  widget.userData["contact"],
                  deviceSize,
                  true,
                ),
                if (!widget.admin) ...[
                  fieldsInUserProfile(
                    'Email- ',
                    widget.userData["email"],
                    deviceSize,
                  ),
                  fieldsInUserProfile(
                    'Hostel- ',
                    widget.userData["hostelName"],
                    deviceSize,
                    true,
                  ),
                  fieldsInUserProfile(
                    'Room no- ',
                    widget.userData["roomNo"],
                    deviceSize,
                    true,
                  ),
                ]
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do you like this application?',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                    TextButton(child: Text("No"), onPressed: () {}),
                  ],
                ),
                Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (Colors.blue[700])!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                        child: Text(
                          "Rate this application",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {}))
              ],
            ),
          ),
        ],
      ),
    );
    // return Center(
    //   child: Column(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(vertical: 20),
    //         child: Text(
    //           "Welcome, ${widget.name}",
    //           style: TextStyle(color: Colors.grey[800], fontSize: 25),
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.symmetric(vertical: 10),
    //         child: Stack(
    //           children: [
    //             Container(
    //               height: deviceSize.height * 0.2,
    //               width: deviceSize.width * 0.4,
    //               decoration: new BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 border: new Border.all(
    //                   color: (Colors.grey[200])!,
    //                   width: 5.0,
    //                 ),
    //               ),
    //               child: CircleAvatar(
    //                 radius: 50,
    //                 backgroundImage:
    //                     AssetImage('assets/images/sample-user.png'),
    //               ),
    //             ),
    //             Positioned(
    //               bottom: 15,
    //               right: 15, //give the values according to your requirement
    //               child: SizedBox(
    //                 height: 20,
    //                 width: 20,
    //                 child: FloatingActionButton(
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(5.0))),
    //                   backgroundColor: Colors.white,
    //                   onPressed: () {},
    //                   child: Icon(
    //                     Icons.edit,
    //                     size: 18,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         width: deviceSize.width,
    //         margin: EdgeInsets.symmetric(vertical: 20),
    //         child: Column(
    //           children: [
    //             fieldsInUserProfile('Name- ', widget.name, deviceSize),
    //             fieldsInUserProfile('Email- ', widget.email, deviceSize),
    //             fieldsInUserProfile(
    //                 'Hostel- ', widget.hostel, deviceSize, true),
    //             fieldsInUserProfile(
    //                 'Room no- ', widget.roomNo, deviceSize, true),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   'Do you like this application?',
    //                   style: TextStyle(fontSize: 18),
    //                 ),
    //                 TextButton(
    //                   child: Text("Yes"),
    //                   onPressed: () {},
    //                   style: TextButton.styleFrom(
    //                     padding: EdgeInsets.all(0),
    //                   ),
    //                 ),
    //                 TextButton(child: Text("No"), onPressed: () {}),
    //               ],
    //             ),
    //             Center(
    //                 child: ElevatedButton(
    //                     style: ButtonStyle(
    //                       backgroundColor: MaterialStateProperty.all<Color>(
    //                           (Colors.blue[700])!),
    //                       shape:
    //                           MaterialStateProperty.all<RoundedRectangleBorder>(
    //                               RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20),
    //                       )),
    //                     ),
    //                     child: Text(
    //                       "Rate this application",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     onPressed: () {}))
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
