import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_bottom_bar_widget.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_account_summary_widget.dart';
import 'dart:math';

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/vet_clinic.jpg'), //TODO replace with the clinic's profile picture
            ),
            const SizedBox(height: 25),
            const Text(
              'Clinic Name',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            const Text(
              'Clinic Address',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            const Text(
              'Clinic Hours',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            const Text(
              'Staff:',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                //  physics: const ClampingScrollPhysics(),
                  children: const [
                    VetAccountSummaryWidget(),
                    VetAccountSummaryWidget(),
                    VetAccountSummaryWidget(),
                    // Add more VetAccountSummaryWidget instances as needed
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  //A popup with a code that can be used by the new staff to join the clinic
                  showDialog(
                    context: context,
                    builder: (context) {
                      return showAlert(context);
                    },
                  );                    

                },
                icon: const Icon(Icons.add, color: Colors.black,),
                label: const Text('Add Staff', style: TextStyle(fontSize: 25, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: VetBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}


AlertDialog showAlert(BuildContext context) {
  int code = Random().nextInt(899999) + 100000;
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
        const Text('Share this code with the new staff member to allow them to join the clinic', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text('Code: $code', style: const TextStyle(fontSize: 25)),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}