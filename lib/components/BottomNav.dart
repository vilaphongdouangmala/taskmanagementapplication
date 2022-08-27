import 'package:flutter/material.dart';
import 'package:task_management_application/styles/AppColor.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: AppColor.primaryRed,
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: AppColor.primaryRed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        });
  }
} //ec
