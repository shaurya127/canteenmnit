import './canteenItemHelp.dart';
import 'package:flutter/material.dart';
import './data.dart';

class CanteenItem extends StatelessWidget {
  Widget buildTitleContainer(String title) {
    return Container(
      height: 40,
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
    );
  }

  final Map<String, List<Data>> list = {
    'Canteen-1': [
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 120),
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 20),
    ],
    'Canteen-2': [
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 80),
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 78),
    ],
    'Canteen-3': [
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 76),
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 85),
    ],
    'Canteen-4': [
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 34),
      Data('title', 'https://unsplash.com/photos/KusGQYgRgSE', 64),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitleContainer(
            'Canteen-1',
          ),
          SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CanteenItemHelp(
                  list['Canteen-1'][index].title,
                  list['Canteen-1'][index].imageUrl,
                  list['Canteen-1'][index].price),
              itemCount: list['Canteen-1'].length,
            ),
          ),
          SizedBox(height: 5),
          buildTitleContainer(
            'Canteen-2',
          ),
          SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CanteenItemHelp(
                  list['Canteen-1'][index].title,
                  list['Canteen-1'][index].imageUrl,
                  list['Canteen-1'][index].price),
              itemCount: list['Canteen-1'].length,
            ),
          ),
          SizedBox(height: 5),
          buildTitleContainer('Canteen-3'),
          SizedBox(height: 2),
          Expnded(
            child: ListView.builder(
              itemBuilder: (context, index) => CanteenItemHelp(
                  list['Canteen-1'][index].title,
                  list['Canteen-1'][index].imageUrl,
                  list['Canteen-1'][index].price),
              itemCount: list['Canteen-1'].length,
            ),
          ),
          SizedBox(height: 5),
          buildTitleContainer('Canteen-4'),
          SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CanteenItemHelp(
                  list['Canteen-1'][index].title,
                  list['Canteen-1'][index].imageUrl,
                  list['Canteen-1'][index].price),
              itemCount: list['Canteen-1'].length,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
