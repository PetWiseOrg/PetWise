import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petwise/features/vet/presentation/widgets/event_start_and_end_times_widget.dart';

class AppointmentRequestsIconWidget extends StatelessWidget {
  final String clientName;
  final DateTime startDate;
  final DateTime endDate;

  const AppointmentRequestsIconWidget({
    super.key,
    required this.clientName,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    String formattedStartDate = formatDate(startDate);
    String formattedEndDate = formatDate(endDate);

    return GestureDetector(
      onTap: () {
        showAddEventForm(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client: $clientName',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start Date: $formattedStartDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'End Date: $formattedEndDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Icon(Icons.calendar_today, size: 40, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('MMMM d, y h:mm a').format(date);
}


void showAddEventForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.75, // Limit the height to 75% of the screen
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding around the form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text('New Event', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 40),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Event Name',
                            ),
                            maxLines: null,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Event Description',
                            ),
                            maxLines: null,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: EventStartAndEndTimesWidget(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Client Name',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Client Name',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pet Name',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pet Name',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pet Species',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pet Species',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pet Breed',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pet Breed',
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}