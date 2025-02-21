import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/pages/vet_bottom_bar.dart';

class VetClinicPage extends StatefulWidget {
  const VetClinicPage({super.key});

  @override
  VetClinicPageState createState() => VetClinicPageState();
}

class VetClinicPageState extends State<VetClinicPage> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: const Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/vet_clinic.jpg'),
          ),
          SizedBox(height: 16),
          Text(
            'Clinic Name',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            'Clinic Address',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            'Clinic Hours',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    ),
  ),
  bottomNavigationBar: VetBottomBar(
    selectedIndex: _selectedIndex,
    onItemTapped: _onItemTapped,
  ),
);
  }
}
