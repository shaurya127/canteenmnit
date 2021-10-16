import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/models/AnyFoodItemOverview.dart';

class OrderDesignInList extends StatelessWidget {
  final double totalAmount;
  final DateTime dtOfOrder;
  final List<AnyFoodItemOverview> foodItemsOrdered;

  OrderDesignInList(
      {required this.totalAmount,
      required this.dtOfOrder,
      required this.foodItemsOrdered});

  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _controller = ScrollController(initialScrollOffset: 0);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: deviceSize.height * 0.15,
      decoration: BoxDecoration(color: Colors.amber[200]),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: Text(
            "Rs " + totalAmount.toString(),
            style: TextStyle(fontSize: 13),
          ),
        ),
        title: RawScrollbar(
            thumbColor: Colors.deepPurple,
            controller: _controller,
            isAlwaysShown: true,
            child: Container(
                height: deviceSize.height * 0.14,
                child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              foodItemsOrdered[i].name,
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue[700]),
                            ),
                            Text(
                              foodItemsOrdered[i].price.toString(),
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.deepPurple[400]),
                            ),
                            Text(
                              foodItemsOrdered[i].quantity.toString(),
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue[700]),
                            ),
                          ]);
                    },
                    itemCount: foodItemsOrdered.length))),
      ),
    );
  }
}
