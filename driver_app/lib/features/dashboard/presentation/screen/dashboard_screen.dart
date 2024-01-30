import 'package:driver_app/features/earning/presentation/screen/earning_screen.dart';
import 'package:driver_app/features/home/presentation/screen/home_screen.dart';
import 'package:driver_app/features/profile/presentation/screen/profile_screen.dart';
import 'package:driver_app/features/trips/presentation/screen/trips_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; //New
  late TabController _tabController;

  final widgetTabs = [
    const HomeScreen(),
    const EarningScreen(),
    const TripsScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: widgetTabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped, //New
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Earning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = _selectedIndex;
    });
  }
}
