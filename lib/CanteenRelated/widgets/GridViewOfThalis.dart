import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import 'overviewOfThaliOnGrid.dart';

class GridViewOfThalis extends StatefulWidget {
  @override
  State<GridViewOfThalis> createState() => _GridViewOfThalisState();
}

class _GridViewOfThalisState extends State<GridViewOfThalis> {
  final List<Widget> thalis =
      List_of_thalis_from_annapurna.map((thali) => OverviewOfThaliOnGrid(
            nameOfThali: thali.name,
            imageURL: thali.imageURL,
            cost: thali.cost,
          )).toList();

  @override
  Widget build(BuildContext context) {
    CarouselController _controller = CarouselController();
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      height: deviceSize.width * 0.7,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
            ),
            carouselController: _controller,
            items: thalis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...Iterable<int>.generate(thalis.length).map(
                (int pageIndex) => Center(
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.lens_rounded),
                      iconSize: 10,
                      color: Colors.deepPurpleAccent[800],
                      onPressed: () => _controller.animateToPage(pageIndex),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
