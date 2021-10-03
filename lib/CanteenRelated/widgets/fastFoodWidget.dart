import 'package:flutter/material.dart';

class FastFoodWidget extends StatelessWidget {
  final String nameOfFastFood;
  final String imageURL;
  final int cost;

  FastFoodWidget({
    required this.nameOfFastFood,
    required this.imageURL,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 30),
            // child: ListTile(
            //   leading: CircleAvatar(
            //     backgroundImage: AssetImage(imageURL),
            //     radius: 30,
            //   ),
            //   // trailing: Text("Rs. $cost/-",
            //   //     // textAlign: TextAlign.center,
            //   //     style: TextStyle(
            //   //         fontSize: 10,
            //   //         fontWeight: FontWeight.w600,
            //   //         color: Colors.blue[900])),
            //   trailing: CircleAvatar(
            //     child: Text("$cost /-",
            //         // textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 10,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.blue[900])),
            //   ),
            // )
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(imageURL),
                      radius: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(nameOfFastFood,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900])),
                  ]),
                ),
                Text("Rs. $cost/-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900])),
              ],
            ),
          )),
    );
  }
}
