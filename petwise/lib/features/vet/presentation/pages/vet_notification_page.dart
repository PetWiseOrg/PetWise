import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/pages/vet_bottom_bar.dart';

class VetNotificationPage extends StatefulWidget {
  const VetNotificationPage({super.key});

  @override
  VetNotificationPageState createState() => VetNotificationPageState();
}

class VetNotificationPageState extends State<VetNotificationPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Center(
        child: Text('Calendar.'),
      ),
      bottomNavigationBar: VetBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
