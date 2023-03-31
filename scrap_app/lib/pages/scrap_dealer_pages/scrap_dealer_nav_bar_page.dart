import 'package:flutter/material.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_history_page/scrap_dealer_purchace_history_page.dart';

import 'scrap_dealer_account_page/scrap_dealer_account_page.dart';
import 'scrap_dealer_alerts_page.dart';
import 'scrap_dealer_homepage/scrap_dealer_main_home_page.dart';
import 'scrap_dealer_map_page.dart';


class ScrapDealerNavBar extends StatefulWidget {
  const ScrapDealerNavBar({Key? key}) : super(key: key);

  @override
  State<ScrapDealerNavBar> createState() => _ScrapDealerNavBarState();
}

class _ScrapDealerNavBarState extends State<ScrapDealerNavBar> {
  int _selectedIndex = 0;
  final List screens = [
    const ScrapDealerHomePage(),
    const ScrapDealerHistoryPage(),
    const ScrapDealerMapPage(),
    const ScrapDealerAlertsPage(),
    const ScrapDealerAccountPage(),
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
          icon: Icon(Icons.map),
          label: 'Map',
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