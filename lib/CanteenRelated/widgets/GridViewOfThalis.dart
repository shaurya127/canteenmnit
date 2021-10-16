import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import 'overviewOfThaliOnGrid.dart';

class GridViewOfThalis extends StatefulWidget {
  @override
  State<GridViewOfThalis> createState() => _GridViewOfThalisState();
}

class _GridViewOfThalisState extends State<GridViewOfThalis> {
  CarouselController _controller = CarouselController();
  final carouselKey = GlobalKey<CarouselSliderState>();
  int _curPage = 0;

  final List<Widget> thalis =
      List_of_thalis_from_annapurna.map((thali) => OverviewOfThaliOnGrid(
            nameOfThali: thali.name,
            imageURL: thali.imageURL,
            cost: thali.cost,
          )).toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    void changeInd(double? ind) {
      _curPage = (ind!.toInt() % 10000) % 3;
      setState(() {});
    }

    return Container(
      height: deviceSize.width * 0.7,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              onScrolled: (ind) => changeInd(ind),
              initialPage: _curPage,
            ),
            carouselController: _controller,
            items: thalis,
            key: carouselKey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...Iterable<int>.generate(thalis.length).map(
                (int pageIndex) => Center(
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.lens_rounded),
                      iconSize: 15,
                      color: _curPage != pageIndex
                          ? Colors.deepPurpleAccent[800]
                          : Colors.red,
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
