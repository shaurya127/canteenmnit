import 'package:flutter/material.dart';
import '../widgets/userProfile.dart';
import '../CanteenRelated/widgets/listOfCanteens.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key? key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  static const List<String?> _options = [
    'Home',
    'Search',
    'Order Lists',
    'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Returns screen based on _selected index
  Widget getScreen() {
    if (_selectedIndex == 0) {
      return ListOfCanteens();
    }

    if (_selectedIndex == 3) {
      return Center(
        child: UserProfile(
          name: "Name",
          email: "abc@xyz.com",
          hostel: "Kabir Hostel",
          roomNo: "82(c)",
          urlOfImage: '',
        ), //Test user
      );
    } else {
      return Center(child: Text("To be filled"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(_options.elementAt(_selectedIndex)!),
      ),
      body: getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Order List',
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
