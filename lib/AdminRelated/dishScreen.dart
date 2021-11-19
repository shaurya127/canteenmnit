import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/CanteenRelated/widgets/CarouselSliderOfThalis.dart';
import 'package:mnit_canteen_app/CanteenRelated/widgets/ListViewOfFastFood.dart';
import '/CanteenRelated/widgets/fastFoodWidgetInListview.dart';
import '/models/Loader.dart';

class DishScreen extends StatelessWidget {
  final String uid;

  DishScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("canteens")
          .doc(uid)
          .collection("dishes")
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) return Loader();
        final dishData = snap.data!.docs;
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Complete Thali Food-",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                GridViewOfThalis(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Fast Food",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: RawScrollbar(
                    isAlwaysShown: true,
                    thumbColor: Colors.blue,
                    thickness: 10,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Dismissible(
                          key: ValueKey(dishData[index].id.toString()),
                          background: Container(
                            color: Theme.of(context).errorColor,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            margin: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 15,
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (dir) {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Are you sure?"),
                                content: Text(
                                  "Do you want to remove this dish?",
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (dir) {
                            FirebaseFirestore.instance
                                .collection("canteens")
                                .doc(uid)
                                .collection('dishes')
                                .doc(dishData[index].id)
                                .delete();
                          },
                          child: FastFoodWidget(
                            dish: dishData[index],
                          ),
                        );
                      },
                      itemCount: dishData.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
