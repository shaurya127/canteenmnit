import './canteenItem.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  List<Object> _pages;
  static const List<Widget> _options = <Widget>[
    Text('Home',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        )),
    Text('Search',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        )),
    Text('Lists',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        )),
    Text('Profile',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
  ];

  @override
  void initState() {
    _pages = [
      CanteenItem(),
      null,
      null,
      null,
    ];
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _options.elementAt(_selectedIndex),
          toolbarHeight: 70,
        ),
        body: _pages[_selectedIndex],
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
                icon: Icon(Icons.format_list_numbered),
                label: 'Order List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_sharp),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.cyan,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            unselectedItemColor: Colors.black,
            elevation: 1));
  }

   @override
   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
