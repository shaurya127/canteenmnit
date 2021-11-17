import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  final bool admin;

  UserProfile({required this.uid, this.admin = false});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.admin ? "canteens" : "users")
          .doc(widget.uid)
          .collection("profile")
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        Map<String, dynamic> profileData =
            snap.data!.docs[0].data() as Map<String, dynamic>;
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
                        backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                        ),
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
                          onPressed: () {},
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
                    ] else ...[
                      fieldsInUserProfile(
                        'Contact- ',
                        profileData["contact"],
                        deviceSize,
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
