import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mnit_canteen_app/AdminRelated/dishScreen.dart';
import 'package:mnit_canteen_app/CanteenRelated/screens/particularCanteenOverview.dart';

import '/Routes/Routes.dart';
import '../add_dish.dart';
import '../../widgets/userProfile.dart';

class MainAdminBody extends StatefulWidget {
  MainAdminBody({Key? key}) : super(key: key);

  @override
  MainAdminBodyState createState() => MainAdminBodyState();
}

class MainAdminBodyState extends State<MainAdminBody> {
  int _selectedIndex = 0;
  final _user = FirebaseAuth.instance.currentUser;

  static const List<String?> _options = [
    'Dishes',
    'Orders',
    'Add Dish',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Returns screen based on _selected index
  Widget getScreen() {
    if (_selectedIndex == 0) {
      return DishScreen(uid: _user!.uid);
    } else if (_selectedIndex == 2) {
      return AddDish(uid: _user!.uid);
    } else if (_selectedIndex == 3) {
      return Center(
        child: UserProfile(
          uid: _user!.uid,
          admin: true,
        ),
      );
    } else {
      return Center(child: Text("To be filled"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_options.elementAt(_selectedIndex)!),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.boardingPage,
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Dishes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: "Add Dish",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
        elevation: 1,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
