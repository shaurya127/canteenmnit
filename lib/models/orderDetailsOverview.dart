import 'dart:ffi';

import 'package:mnit_canteen_app/models/AnyFoodItemOverview.dart';

class OrderDetailsOverview {
  String studentID = "";
  double totalAmount = 0.0;
  DateTime dtOfOrder = DateTime.now();
  List<AnyFoodItemOverview> foodItemsOrdered = List.empty();

  OrderDetailsOverview(String studentId, DateTime dtOfOrder,
      List<AnyFoodItemOverview> foodItemsOrdered) {
    this.studentID = studentId;
    this.dtOfOrder = dtOfOrder;
    this.foodItemsOrdered = foodItemsOrdered;
    calcTotalAmount();
  }

  void calcTotalAmount() {
    this.foodItemsOrdered.forEach((element) {
      this.totalAmount = this.totalAmount + element.price;
    });
  }
}
