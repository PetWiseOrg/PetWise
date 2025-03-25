import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    String startDate = formatDate(this.startDate);
    String endDate = formatDate(this.endDate);
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
                  'Client: $clientName',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start Date: $startDate',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'End Date: $endDate',
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

String formatDate(DateTime date) {
  return DateFormat('MMMM d, y h:mm a').format(date);
}