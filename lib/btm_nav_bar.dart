import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1; // Initialize selected index to 1

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the initial selected index based on the current route
    _selectedIndex = _getSelectedIndexFromRoute(ModalRoute.of(context)?.settings.name);
  }

  int _getSelectedIndexFromRoute(String? routeName) {
    // Determine the selected index based on the current route
    switch (routeName) {
      case '/home':
        return 1;
      case '/acc':
        return 0;
      default:
        return 1;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      Navigator.pushNamed(context, '/home'); // Navigate to the home page
    } else if (_selectedIndex == 0) {
      Navigator.pushNamed(context, '/acc'); // Navigate to the account page
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle , size: 28,),
          label: 'حسابي',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home , size: 28,),
          label: 'الرئسية',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFFA779F7), 
      unselectedItemColor: const Color.fromARGB(255, 188, 188, 188),
      backgroundColor:Color(0xFFF2E5FF) ,// Change the color of the selected item here
      onTap: _onItemTapped,
    );
  }
}

