import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekTimeSlotPicker extends StatefulWidget {
  final DateTime startOfWeek;
  final Function(DateTime selectedDateTime) onTimeSlotSelected;

  const WeekTimeSlotPicker({
    super.key,
    required this.startOfWeek,
    required this.onTimeSlotSelected,
  });

  @override
  _WeekTimeSlotPickerState createState() => _WeekTimeSlotPickerState();
}

class _WeekTimeSlotPickerState extends State<WeekTimeSlotPicker> {
  DateTime? selectedDate;
  DateTime? selectedTimeSlot;

  final List<String> timeSlots = [
    '9:00 AM', '10:00 AM', '11:00 AM',
    '1:00 PM', '2:00 PM', '3:00 PM',
    '5:00 PM', '6:00 PM'
  ];

  List<DateTime> generateWeekDays(DateTime start) {
    return List.generate(7, (index) => start.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = generateWeekDays(widget.startOfWeek);
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 32) / 7; // 16 padding on each side

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Days Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays.map((date) {
            final isSelected = selectedDate?.day == date.day &&
                selectedDate?.month == date.month &&
                selectedDate?.year == date.year;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = date;
                  selectedTimeSlot = null;
                });
              },
              child: Container(
                width: itemWidth,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white70,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.black12,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('MMM').format(date), // Apr
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${date.day}', // 11
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        if (selectedDate != null) ...[
          const Text(
            "Available Time Slots",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: timeSlots.map((slot) {
              final slotDateTime = _getDateTimeFromSlot(selectedDate!, slot);
              final isSelected = selectedTimeSlot == slotDateTime;

              return ChoiceChip(
                label: Text(
                  slot,
                  style: TextStyle(color: Colors.black),
                ),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedTimeSlot = slotDateTime;
                  });
                  widget.onTimeSlotSelected(slotDateTime);
                },
                selectedColor: Colors.white70,
                backgroundColor: Colors.white60,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.black : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  DateTime _getDateTimeFromSlot(DateTime date, String slot) {
    final timeParts = slot.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1] == 'PM';

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}