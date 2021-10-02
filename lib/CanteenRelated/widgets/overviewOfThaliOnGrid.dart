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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
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
                          fontSize: 10),
                    ),
                  )),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageURL),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10)),
          ),
          Text(
            'Rs $cost/-',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
