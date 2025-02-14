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

  void _onViewAllTapped() {
    // Handle the "View All" tap here
    print('View All tapped');
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
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  'John Smith', //TODO Replace with the user's name
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
            ),
            SizedBox(width: 15), // Space between text and profile picture
            Spacer(), // Push the profile picture to the right
            CircleAvatar(
              radius: 40, // Increase the size of the profile picture
              backgroundImage: AssetImage('assets/profile.jpg'), //TODO replace with the user's profile picture
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // Space from the top
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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
          const Spacer(), // Push the grey box to the bottom
          GestureDetector(
            onTap: _onViewAllTapped,
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14), // Increase the height
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Add margin to float above bottom bar and not touch sides
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.black),
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