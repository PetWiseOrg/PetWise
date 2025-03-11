import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_bottom_bar_widget.dart';

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

  //TODO this can probably be removed 
  void _onViewAllTapped() {
    // Handle the "View All" tap here
    print('View All tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150, 
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, 
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
            SizedBox(width: 15), 
            Spacer(), 
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.jpg'), //TODO replace with the user's profile picture
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
           SizedBox(height: 20), 
           Padding(
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
                    thickness: 1, 
                    indent: 10,
                    endIndent: 10, 
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