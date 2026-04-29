import 'package:expense_app/user_interface/pages/dashboard/navigation_page/about_nav_page.dart';
import 'package:expense_app/user_interface/pages/dashboard/navigation_page/add_nav_page.dart';
import 'package:expense_app/user_interface/pages/dashboard/navigation_page/chart_nav_page.dart';
import 'package:expense_app/user_interface/pages/dashboard/navigation_page/home_nav_page.dart';
import 'package:expense_app/user_interface/pages/dashboard/navigation_page/notification_nav_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> myNavPages = [
    HomeNavPage(),
    ChartNavPage(),
    AddNavPage(),
    NotificationNavPage(),
    AboutNavPage(),
  ];

  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myNavPages[selectedNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedNavIndex = value;
          setState(() {});
        },
        currentIndex: selectedNavIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey, size: 30),
            label: "Home",
            activeIcon: Icon(Icons.home, color: Colors.pink.shade300, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.grey, size: 30),
            label: "Dashboard",
            activeIcon: Icon(
              Icons.bar_chart,
              color: Colors.pink.shade300,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              height: 63,
              width: 63,
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Icon(Icons.add),
              ),
            ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.notifications_active, color: Colors.grey, size: 30),
            activeIcon: Icon(
              Icons.notifications_active,
              color: Colors.pink.shade300,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.person, color: Colors.grey, size: 30),
            activeIcon: Icon(
              Icons.person,
              color: Colors.pink.shade300,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
