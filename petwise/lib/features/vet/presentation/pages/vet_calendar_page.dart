import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_bottom_bar_widget.dart';

class VetCalendarPage extends StatefulWidget {
  const VetCalendarPage({super.key});

  @override
  VetCalendarPageState createState() => VetCalendarPageState();
}

class VetCalendarPageState extends State<VetCalendarPage> {
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
