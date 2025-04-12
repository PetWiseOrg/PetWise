import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/common_widgets/week_time_slot_picker.dart';

class AppointmentDateTimePage extends StatefulWidget {
  final String clinicName;
  final double rating;
  final String address;
  final String concernsSummary; // optional now, still placeholder

  const AppointmentDateTimePage({
    super.key,
    required this.clinicName,
    required this.rating,
    required this.address,
    this.concernsSummary = 'TODO: JSON from the chat summary',
  });

  @override
  State<AppointmentDateTimePage> createState() => _AppointmentDateTimePageState();
}

class _AppointmentDateTimePageState extends State<AppointmentDateTimePage> {
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Appointment Date/Time',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: WeekTimeSlotPicker(
                startOfWeek: startOfWeek,
                onTimeSlotSelected: (DateTime pickedDateTime) {
                  setState(() {
                    selectedDateTime = pickedDateTime;
                  });
                },
              ),
            ),
            if (selectedDateTime != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.appointmentSummaryPage.name,
                      extra: {
                        'clinicName': widget.clinicName,
                        'rating': widget.rating,
                        'address': widget.address,
                        'appointmentDateTime': selectedDateTime!,
                        'concernsSummary': widget.concernsSummary,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Continue to Summary'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}