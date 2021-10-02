import 'package:flutter/material.dart';
import '../screens/particularCanteenOverview.dart';

class CanteenDetailsOnMainScreen extends StatelessWidget {
  final String nameOfCanteen;
  final String imageURL;

  CanteenDetailsOnMainScreen(
      {required this.nameOfCanteen, required this.imageURL});

  void displayTheCanteen(BuildContext context) {
    Navigator.of(context).pushNamed(ParticularCanteenOverview.routeName,
        arguments: {'nameOfCanteen': nameOfCanteen, 'imageURL': imageURL});
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
                nameOfCanteen,
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
            image: AssetImage(imageURL),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
