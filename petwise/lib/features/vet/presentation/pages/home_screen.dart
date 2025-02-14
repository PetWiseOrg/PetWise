import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/pages/vet_clinic_page.dart';
import 'package:petwise/features/vet/presentation/pages/vet_dashboard.dart';
import 'package:petwise/features/vet/presentation/pages/vet_notifications.dart';
import 'package:petwise/features/vet/presentation/pages/vet_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    VetDashboardPage(),
    VetClinicPage(),
    VetNotificationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: VetBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
