import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import 'overviewOfThaliOnGrid.dart';

class GridViewOfThalis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        height: deviceSize.width * 0.53,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) => OverviewOfThaliOnGrid(
            nameOfThali: List_of_thalis_from_annapurna[i].name,
            imageURL: List_of_thalis_from_annapurna[i].imageURL,
            cost: List_of_thalis_from_annapurna[i].cost,
          ),
          itemCount: 3,
        ));
  }
}
