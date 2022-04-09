import 'package:flutter/material.dart';
import 'package:lab_crud/view/add_contact_page.dart';
import 'package:lab_crud/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab_crud/view/settings_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ Key? key }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int currentIndex = 0;

  final screens = [
    const HomeContacts(),
    const AddContact(),
    const SettingsScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.blue,
        inactiveColor: Colors.black,
        currentIndex: currentIndex,
        border: Border.all(color: Colors.transparent),
        onTap: (int index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_call),
            label: 'Add Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ]
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: screens[currentIndex],
          );
        });
      },
    );
  }
}