import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/pages/vet_bottom_bar.dart';

class VetDashboardPage extends StatefulWidget {
  const VetDashboardPage({super.key});

  @override
  _VetDashboardPageState createState() => _VetDashboardPageState();
}

class _VetDashboardPageState extends State<VetDashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150, // Increase the height of the AppBar
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(fontSize: 25, color: Colors.black54),
                ),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            SizedBox(width: 15), // Space between text and profile picture
            Spacer(), // Push the profile picture to the right
            CircleAvatar(
              radius: 40, // Increase the size of the profile picture
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with a network image if needed
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20), // Space from the top
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5), // Space between text and line
                  Divider(
                    color: Color.fromARGB(255, 217, 217, 217), // Faint line color
                    thickness: 1, // Line thickness
                    indent: 10, // Start padding
                    endIndent: 10, // End padding
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: VetBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
