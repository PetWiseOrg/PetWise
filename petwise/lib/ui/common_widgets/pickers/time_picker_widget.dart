import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends StatefulWidget {
  final DateTime? initialDateTime;

  const TimePickerWidget({super.key, this.initialDateTime});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime ?? nearestHalf(DateTime.now());
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? newDateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: _selectedDateTime!,
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
          child: buildDateTimeText(_selectedDateTime!),
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
  return DateFormat('MMMM d, y h:mm a').format(date);
}

Widget buildDateTimeText(DateTime dateTime) {
  if (dateTime.isBefore(DateTime.now())) {
    return Text(
      formatDate(dateTime),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.red,
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.red,
      ),
    );
  }
  return Text(
    formatDate(dateTime),
    style: const TextStyle(fontSize: 16, color: Colors.black),
  );
}