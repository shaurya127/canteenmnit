import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/models/getImage.dart';

import '../../Routes/Routes.dart';

class CanteenDetailsOnMainScreen extends StatefulWidget {
  final dynamic canteen;

  CanteenDetailsOnMainScreen({required this.canteen});

  @override
  State<CanteenDetailsOnMainScreen> createState() =>
      _CanteenDetailsOnMainScreenState();
}

class _CanteenDetailsOnMainScreenState
    extends State<CanteenDetailsOnMainScreen> {
  void displayTheCanteen(BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.canteenDetail,
      arguments: {'canteen': widget.canteen},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          displayTheCanteen(context);
        },
        splashColor: Colors.blue[100],
        child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.canteen.data()["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            )),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getImgUrl(
            widget.canteen.data()["imgUrl"],
            null,
            true,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
