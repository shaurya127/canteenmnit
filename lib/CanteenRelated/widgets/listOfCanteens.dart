import 'package:flutter/material.dart';
import 'package:mnit_canteen/CanteenRelated/widgets/canteenDetailsOnMainScreen.dart';
import '../../dummy_data.dart';

class ListOfCanteens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GridView(
          padding: const EdgeInsets.all(10),
          children: List_of_canteens_data.map(
              (canteenInfo) => CanteenDetailsOnMainScreen(
                    nameOfCanteen: canteenInfo.name,
                    imageURL: canteenInfo.imageURL,
                  )).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 3 / 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          )),
    );
  }
}
