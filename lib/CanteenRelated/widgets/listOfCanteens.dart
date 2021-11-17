import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../CanteenRelated/widgets/canteenDetailsOnMainScreen.dart';
import '../../dummy_data.dart';

class ListOfCanteens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("canteens").snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        final List<dynamic> canteenData = snap.data!.docs;
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: GridView(
            padding: const EdgeInsets.all(10),
            children: canteenData.map((e) {
              return CanteenDetailsOnMainScreen(canteen: e);
            }).toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
            ),
          ),
        );
      },
    );
  }
}
