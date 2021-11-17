import 'package:flutter/material.dart';

import '../../Routes/Routes.dart';

class CanteenDetailsOnMainScreen extends StatelessWidget {
  final dynamic canteen;

  CanteenDetailsOnMainScreen({required this.canteen});

  void displayTheCanteen(BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.canteenDetail,
      arguments: {'canteen': canteen},
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
                canteen.data()["name"],
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
            image: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
