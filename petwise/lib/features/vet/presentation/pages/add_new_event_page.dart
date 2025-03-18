import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:intl/intl.dart';

class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({super.key});

  @override
  AddNewEventPageState createState() => AddNewEventPageState();
}

String formatDate() {
  DateTime now = DateTime.now();

  // Round up minutes to the nearest 30-minute mark
  int remainder = now.minute % 30;
  int minutesToAdd = (remainder == 0) ? 30 : (30 - remainder);
  DateTime roundedTime = now.add(Duration(minutes: minutesToAdd));

  // If the minutes round to exactly the next hour, reset to :00 minutes
  if (roundedTime.minute == 60) {
    roundedTime = DateTime(
      roundedTime.year,
      roundedTime.month,
      roundedTime.day,
      roundedTime.hour + 1,
      0,
    );
  }

  // Format the final datetime
  return DateFormat("MMMM d, y h:00 a").format(roundedTime);
}

class AddNewEventPageState extends State<AddNewEventPage> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate();
    return Scaffold(
      appBar: AppBar(
        leading:           
        IconButton(
            onPressed: () {
              context.goNamed(AppRoute.vetDashboardPage.name);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        actions: [
          
          IconButton(
            onPressed: () {
              context.goNamed(AppRoute.vetDashboardPage.name);
            },
            icon: const Icon(Icons.save),
          ),

        ],
      ),
      //Fields for the event details
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add event',
                ),
                maxLines: null,

              ),
            ),
            //Time select bar
            //Similar to google calendar view
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 60,
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
