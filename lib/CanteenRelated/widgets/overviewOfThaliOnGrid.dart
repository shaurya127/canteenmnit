import 'package:flutter/material.dart';

class OverviewOfThaliOnGrid extends StatelessWidget {
  final String nameOfThali;
  final String imageURL;
  final int cost;

  OverviewOfThaliOnGrid(
      {required this.nameOfThali, required this.imageURL, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageURL),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.blue[100],
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          nameOfThali,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Text(
            'Rs $cost/-',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
