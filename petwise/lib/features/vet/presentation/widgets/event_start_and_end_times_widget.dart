import 'package:flutter/material.dart';
import 'package:petwise/ui/common_widgets/pickers/time_picker_widget.dart';

class EventStartAndEndTimesWidget extends StatefulWidget {
  const EventStartAndEndTimesWidget({Key? key}) : super(key: key);

  @override
  _EventStartAndEndTimesWidgetState createState() => _EventStartAndEndTimesWidgetState();
}

class _EventStartAndEndTimesWidgetState extends State<EventStartAndEndTimesWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startTime = nearestHalf(now);
    DateTime endTime = startTime.add(const Duration(minutes: 30));

    return Column(
      children: [
        const SizedBox(height: 30),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Starts: ', style: TextStyle(fontSize: 20)),
            TimePickerWidget(),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ends: ', style: TextStyle(fontSize: 20)),
            TimePickerWidget(
              initialDateTime: endTime,
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

DateTime nearestHalf(DateTime val) {
  int newMinute = (val.minute <= 30) ? 30 : 0;
  int newHour = (newMinute == 0) ? val.hour + 1 : val.hour;

  return DateTime(val.year, val.month, val.day, newHour, newMinute);
}
