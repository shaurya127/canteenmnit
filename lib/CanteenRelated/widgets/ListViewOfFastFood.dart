import 'package:flutter/material.dart';
import '../../dummy_data.dart';
import 'fastFoodWidget.dart';

class ListViewOfFastFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return FastFoodWidget(
            nameOfFastFood: List_of_all_fast_food[index].name,
            imageURL: List_of_all_fast_food[index].imageURL,
            cost: List_of_all_fast_food[index].cost,
          );
        },
        itemCount: List_of_all_fast_food.length,
      ),
    );
  }
}
