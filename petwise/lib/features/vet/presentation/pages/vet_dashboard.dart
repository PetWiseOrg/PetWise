import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_bottom_bar_widget.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_calendar_event_widget.dart';
import 'package:petwise/features/vet/presentation/widgets/event_start_and_end_times_widget.dart';
import 'package:petwise/features/vet/presentation/widgets/appointment_requests_widget.dart';

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
      body: Column(
        children: [
          //    const AppointmentRequestsWidget(),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appointment Requests',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5), // Space between text and line
                    const Divider(
                      color: Color.fromARGB(255, 217, 217, 217), // Faint line color
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                ),
              )),
          const AppointmentRequestsWidget(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 20),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  VetCalendarEventWidget(
                    appointmentTime: '12:00 PM',
                    clientName: 'John Doe',
                    petName: 'Fido',
                  ),
                  VetCalendarEventWidget(
                    appointmentTime: '1:00 PM',
                    clientName: 'Jane Smith',
                    petName: 'Whiskers',
                  ),
                  VetCalendarEventWidget(
                    appointmentTime: '2:00 PM',
                    clientName: 'Alice Johnson',
                    petName: 'Buddy',
                  ),
                  // Add more VetCalendarEventWidget instances as needed
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       showAddEventForm(context);
          //     },
          //     icon: const Icon(Icons.add),
          //     label: const Text('Add Event', style: TextStyle(fontSize: 22, color: Colors.black)),
          //     style: ElevatedButton.styleFrom(
          //       padding: const EdgeInsets.all(16.0),
          //       backgroundColor: Colors.grey[300],
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(0),
          //       ),
          //       minimumSize: const Size(double.infinity, 50),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: VetBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
