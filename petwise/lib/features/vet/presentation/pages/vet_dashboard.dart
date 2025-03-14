import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_bottom_bar_widget.dart';
import 'package:petwise/features/vet/presentation/widgets/vet_calendar_event_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/navigation/routing.dart';

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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 5), // Space between text and line
                  const Divider(
                    color: Color.fromARGB(255, 217, 217, 217), // Faint line color
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),

                  //TODO this will have a listview showing the upcoming appointments. It will start from next appointment and go down from there.
                  //It will be divided by day, with the date at the top of each day.

                  SizedBox(
                    height: 520,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        //  physics: const ClampingScrollPhysics(),

                        children: const [
                          VetCalendarEventWidget(
                            appointmentTime: '12:00 PM',
                            clientName: 'John Doe',
                            petName: 'Fido',
                          ),
                          VetCalendarEventWidget(
                            appointmentTime: '12:00 PM',
                            clientName: 'John Doe',
                            petName: 'Fido',
                          ),
                          VetCalendarEventWidget(
                            appointmentTime: '12:00 PM',
                            clientName: 'John Doe',
                            petName: 'Fido',
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Add event button
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.goNamed(AppRoute.addNewEventPage.name);
                        print('Add Event tapped');
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Event', style: TextStyle(fontSize: 22, color: Colors.black)),
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
