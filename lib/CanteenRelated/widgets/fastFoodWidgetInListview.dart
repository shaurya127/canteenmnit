import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/models/getImage.dart';

class FastFoodWidget extends StatelessWidget {
  final dynamic dish;

  FastFoodWidget({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: getImgUrl(
                          dish.data()["imgUrl"],
                          null,
                          true,
                        ),
                        radius: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        dish.data()["name"],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Rs. ${dish.data()["price"]}/-",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
