import 'models/FastFoodOverview.dart';
import 'models/canteenOverview.dart';
import 'models/thaliOverview.dart';

final List_of_canteens_data = [
  CanteenOverView(
      name: 'Annapurna Canteen', imageURL: 'assets/images/food1.jpeg'),
  CanteenOverView(name: 'Amul Canteen', imageURL: 'assets/images/food2.jpg'),
  CanteenOverView(name: 'H.4 Canteen', imageURL: 'assets/images/food3.jpg'),
  CanteenOverView(name: 'Gargi Canteen', imageURL: 'assets/images/food4.jpeg'),
];

//Later on, modify this to have id which comes from firebase
final List_of_thalis_from_annapurna = [
  ThaliOverview(
    name: 'Special Thali',
    imageURL: 'assets/images/food1.jpeg',
    cost: 120,
  ),
  ThaliOverview(
    name: 'Raj Thali',
    imageURL: 'assets/images/food2.jpg',
    cost: 240,
  ),
  ThaliOverview(
    name: 'MNIT Special',
    imageURL: 'assets/images/food3.jpg',
    cost: 90,
  ),
];

//Later on, modify this to have id which comes from firebase
final List_of_all_fast_food = [
  FastFoodOverview(
    name: 'Kachori',
    imageURL: 'assets/images/kachori.png',
    cost: 5,
  ),
  FastFoodOverview(
    name: 'Burger',
    imageURL: 'assets/images/burger.jpg',
    cost: 50,
  ),
  FastFoodOverview(
    name: 'Pizza',
    imageURL: 'assets/images/pizza.png',
    cost: 100,
  ),
];
