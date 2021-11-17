import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../dummy_data.dart';
import 'fastFoodWidgetInListview.dart';

class ListViewOfFastFood extends StatelessWidget {
  final dynamic canteen;

  ListViewOfFastFood({required this.canteen});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("canteens")
          .doc(canteen.id)
          .collection("dishes")
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        final dishData = snap.data!.docs;
        return Expanded(
          child: RawScrollbar(
            isAlwaysShown: true,
            thumbColor: Colors.blue,
            thickness: 10,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return FastFoodWidget(
                  dish: dishData[index],
                );
              },
              itemCount: dishData.length,
            ),
          ),
        );
      },
    );
  }
}
