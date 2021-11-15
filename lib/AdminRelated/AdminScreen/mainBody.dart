import 'package:flutter/material.dart';

import '../add_dish.dart';
import '../../widgets/userProfile.dart';

class MainAdminBody extends StatefulWidget {
  MainAdminBody({Key? key}) : super(key: key);

  @override
  MainAdminBodyState createState() => MainAdminBodyState();
}

class MainAdminBodyState extends State<MainAdminBody> {
  int _selectedIndex = 0;

  static const List<String?> _options = [
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
    if (_selectedIndex == 1) {
      return AddDish();
    } else if (_selectedIndex == 2) {
      return Center(
        child: UserProfile(
          // name: "Name",
          // email: "abc@xyz.com",
          // hostel: "Kabir Hostel",
          // roomNo: "82(c)",
          // urlOfImage: '',
          uid: "",
        ), //Test user
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
      ),
      body: getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
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
