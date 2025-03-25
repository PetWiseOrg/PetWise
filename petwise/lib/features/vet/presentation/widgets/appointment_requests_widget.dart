import 'package:flutter/material.dart';
import 'package:petwise/features/vet/presentation/widgets/appointment_requests_icon_widget.dart';

class AppointmentRequestsWidget extends StatelessWidget {
  const AppointmentRequestsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppointmentRequestsIconWidget(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 7)),
              clientName: "John Doe",
            ),
            AppointmentRequestsIconWidget(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 7)),
              clientName: "John Doe",
            ),
            AppointmentRequestsIconWidget(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 7)),
              clientName: "John Doe",
            ),
            // Add more VetCalendarEventWidget instances as needed
          ],
        ),
      ),
    );
  }
}
