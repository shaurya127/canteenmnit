import 'package:flutter/foundation.dart';

class Data {
  String title;
  String imageUrl;
  int price;
  bool isFavourite ;

  Data(
    @required this.title,
    @required this.imageUrl,
    @required this.price, {
    this.isFavourite = true,
  });
}
