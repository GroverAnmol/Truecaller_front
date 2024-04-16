import 'package:flutter/material.dart';
import 'package:untitled36/screens/contacts_screen.dart';
import 'package:untitled36/screens/dial_screen.dart';
import 'package:untitled36/screens/recent_call_log_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = DialScreen();
    if (_selectedPageIndex == 1) {
      activePage = const RecentsCallLogScreen();
    } else if (_selectedPageIndex == 2){
      activePage = const ContactsScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.apps), label: 'Dial'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded), label: 'Recents'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts_rounded), label: 'Contacts'),
        ],
      ),
    );
  }
}