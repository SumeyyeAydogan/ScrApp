import 'package:flutter/material.dart';
import 'package:scrap_app/pages/user_pages/user_account_page/user_account_page.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/user_main_home_page.dart';

import 'user_alerts_page.dart';
import 'user_history_page/user_history_page.dart';


class UserNavBar extends StatefulWidget {
  const UserNavBar({Key? key}) : super(key: key);

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  int _selectedIndex = 0;
  final List screens = [
    const UserHomePage(),
    const UserSalesHistoryPage(),
    const UserAlertsPage(),
    const UserAccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_important),
          label: 'Alerts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts_outlined),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }
}