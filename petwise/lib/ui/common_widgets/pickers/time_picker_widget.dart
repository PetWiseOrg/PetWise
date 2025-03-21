import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  DateTime? _selectedDateTime = nearestHalf(DateTime.now());

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? newDateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 30,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );

    if (newDateTime != null) {
      setState(() {
        _selectedDateTime = nearestHalf(newDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 195, 195, 195),
          ),
          onPressed: () => _selectDateTime(context),
          child: Text(
            formatDate(_selectedDateTime!), // Corrected this part
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),

      ],
    );
  }
}

DateTime nearestHalf(DateTime val) {
  int newMinute = (val.minute <= 30) ? 30 : 0; 
  int newHour = (newMinute == 0) ? val.hour + 1 : val.hour; 

  return DateTime(val.year, val.month, val.day, newHour, newMinute);
}


String formatDate(DateTime date) {
  return DateFormat('MMMM d, y h:mm a').format(date); // Fixed extra space in 'h mm a'
}
