import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  final bool admin;

  UserProfile({required this.uid, this.admin = false});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? imgChosen;

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
          onPressed: () {},
          child: Icon(
            Icons.edit,
            size: 18,
            color: Colors.black,
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
        iconToBeIncluded
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

  ImageProvider getImgUrl(String? img) {
    if (imgChosen != null) return FileImage(imgChosen!);
    return img != null
        ? FadeInImage(
            placeholder: Image.asset("assets/images/" +
                    (widget.admin ? "Canteenmnit-logo.jpg" : "profile-img.png"))
                .image,
            image: NetworkImage(img),
          ).image
        : Image.asset("assets/images/" +
                (widget.admin ? "Canteenmnit-logo.jpg" : "profile-img.png"))
            .image;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.admin ? "canteens" : "users")
          .doc(widget.uid)
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        Map<String, dynamic> profileData =
            snap.data!.data() as Map<String, dynamic>;
        return Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Welcome, ${profileData["name"].toString().split(" ")[0]}",
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
                        backgroundImage: getImgUrl(profileData["imgUrl"]),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15, //give the values according to your requirement
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
                      profileData["name"],
                      deviceSize,
                    ),
                    fieldsInUserProfile(
                      'Contact- ',
                      profileData["contact"],
                      deviceSize,
                    ),
                    if (!widget.admin) ...[
                      fieldsInUserProfile(
                        'Email- ',
                        profileData["email"],
                        deviceSize,
                      ),
                      fieldsInUserProfile(
                        'Hostel- ',
                        profileData["hostelName"],
                        deviceSize,
                        true,
                      ),
                      fieldsInUserProfile(
                        'Room no- ',
                        profileData["roomNo"],
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
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
      },
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
