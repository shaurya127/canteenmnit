import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/models/Loader.dart';

import '../widgets/bottombar.dart';

class HomeScreen extends StatelessWidget {
  final String uid;

  HomeScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    //Here is the main home screen of the app
    return Scaffold(
      extendBody: true, // very important as noted
      // bottomNavigationBar: NavigationBar(),
      backgroundColor: Colors.blue[50],
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Loader();
          final userData = snap.data!.data() as Map<String, dynamic>;
          return NavigationBar(uid: uid, userData: userData);
        },
      ),
    );
  }
}
