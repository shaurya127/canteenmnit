import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/models/Loader.dart';

import './AdminScreen/mainBody.dart';

class AdminScreen extends StatelessWidget {
  final String uid;

  AdminScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("canteens")
            .doc(uid)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Loader();
          final userData = snap.data!.data() as Map<String, dynamic>;
          return MainAdminBody(uid: uid, userData: userData);
        },
      ),
    );
  }
}
