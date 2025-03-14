import 'package:flutter/material.dart';

class VetCalendarEventWidget extends StatelessWidget {
  final String appointmentTime;
  final String clientName;
  final String petName;

  const VetCalendarEventWidget({
    super.key,
    required this.appointmentTime,
    required this.clientName,
    required this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Appointment Time: $appointmentTime',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Client: $clientName',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pet: $petName',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Icon(Icons.calendar_today, size: 40, color: Colors.black),
        ],
      ),
    );
  }
}