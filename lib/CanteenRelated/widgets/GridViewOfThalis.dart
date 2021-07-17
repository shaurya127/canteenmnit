import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import 'overviewOfThaliOnGrid.dart';

class GridViewOfThalis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height:
          100, //Here optimization required so that height of container is same as the content
      child: GridView(
          padding: const EdgeInsets.all(10),
          children: List_of_thalis_from_annapurna.map(
              (thaliInfo) => OverviewOfThaliOnGrid(
                    nameOfThali: thaliInfo.name,
                    imageURL: thaliInfo.imageURL,
                    cost: thaliInfo.cost,
                  )).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 3 / 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          )),
    );
  }
}
