import 'package:flutter/material.dart';
import '../widgets/ListViewOfFastFood.dart';
import '../widgets/GridViewOfThalis.dart';

class ParticularCanteenOverview extends StatelessWidget {
  static const routeName = '/particular-canteen-overview';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final nameOfCanteen = routeArguments['nameOfCanteen'];
    final imageURL = routeArguments['imageURL'];

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          nameOfCanteen,
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          // transformAlignment: AlignmentGeometry(),
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
              ListViewOfFastFood(),
            ],
          )),
    );
  }
}
