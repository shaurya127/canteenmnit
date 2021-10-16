import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/Routes/Routes.dart';
import 'package:mnit_canteen_app/StudentRelated/particularOrderDesignInList.dart';
import 'package:mnit_canteen_app/dummy_data.dart';
import 'package:mnit_canteen_app/widgets/authScreenForm.dart';

class OrderList extends StatelessWidget {
  final studentID;

  OrderList({this.studentID});

  // boolean isAuthenticated()   --> Implement this function
  bool isAuthenticated() {
    if (this.studentID == 'abcd') {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: deviceSize.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          this.isAuthenticated()
              ? Center(
                  child: RawScrollbar(
                    thumbColor: Colors.deepPurple,
                    child: Container(
                        height: deviceSize.height,
                        //Here fetch all the order details according to the studentID
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: Text(
                                      'Total Amount',
                                      style: TextStyle(fontSize: 22),
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Order dish',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Total cost of dish',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      'Quantity of that dish',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22),
                                    )),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (ctx, i) {
                                  return OrderDesignInList(
                                      totalAmount:
                                          List_of_orders[i].totalAmount,
                                      foodItemsOrdered:
                                          List_of_orders[i].foodItemsOrdered,
                                      dtOfOrder: List_of_orders[i].dtOfOrder);
                                },
                                itemCount: List_of_orders.length,
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              : Center(
                  child: AlertDialog(
                    title: Text('Failed to authenticate'),
                    content: Text("Please login/signup"),
                    actions: [
                      FlatButton(
                          onPressed: () => {
                                Navigator.of(context)
                                    .popAndPushNamed(Routes.mainAuth)
                              },
                          child: Text('Okay'))
                    ],
                  ),
                ),
        ]),
      ),
    );
  }
}
