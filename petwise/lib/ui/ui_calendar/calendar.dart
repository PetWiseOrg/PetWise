import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var controller = EventController();

var headerStyle = const HeaderStyle(
  decoration: BoxDecoration(
    color: Colors.blue,
  ),
  headerTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
  ),
);

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Widget? calendarView;
  Widget? buttonRow;
  DateTime selectedDate = DateTime.now();
  Function(DateTime)? onDateClick;

  @override
  void initState() {
    super.initState();
    onDateClick = dayView;
    monthView(selectedDate);
  }

  void dayView(DateTime date) {
    setState(() {
      selectedDate = date;
      onDateClick = dayView;
      calendarView = DayView(
        controller: controller,
        initialDay: selectedDate,
        // headerStyle: headerStyle,
        onPageChange: (date, page) => selectedDate = date,
        dateStringBuilder: (date, {secondaryDate}) => '${DateFormat.yMMMMd().format(date)}\n${DateFormat.EEEE().format(date)}',
      );
      buttonRow = Row(
        children: [
          ElevatedButton(
            onPressed: () => monthView(selectedDate),
            child: const Text('<- Month'),
          ),
          ElevatedButton(onPressed: () => weekView(selectedDate), child: const Text('Week')),
        ],
      );
    });
  }

  void weekView(DateTime date) {
    setState(() {
      selectedDate = date;
      onDateClick = weekView;
      calendarView = WeekView(
        controller: controller,
        initialDay: selectedDate,
        startDay: WeekDays.sunday,
        onPageChange: (date, page) => selectedDate = date,
        // headerStyle: headerStyle,
        headerStringBuilder: (date, {secondaryDate}) => '${DateFormat.MMMMd().format(date)} - ${DateFormat.yMMMMd().format(secondaryDate!)}',
      );
      buttonRow = Row(
        children: [
          ElevatedButton(
            onPressed: () => monthView(selectedDate),
            child: const Text('<- Month'),
          ),
          ElevatedButton(onPressed: () => dayView(selectedDate), child: const Text('Day')),
        ],
      );
    });
  }

  void monthView(DateTime date) {
    setState(() {
      selectedDate = date;
      calendarView = MonthView(
        controller: controller,
        initialMonth: selectedDate,
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => selectedDate = date,
        onCellTap: (events, date) => onDateClick!(date),
        onDateLongPress: (date) => print(date),
        onEventTap: (event, date) => print(event),
        onEventDoubleTap: (events, date) => print(events),
        onEventLongTap: (event, date) => print(event),
        showWeekTileBorder: false, // To hide header border
        hideDaysNotInMonth: true, // To hide days or cell that are not in current month
        useAvailableVerticalSpace: true,
        // headerStyle: headerStyle,
        headerStringBuilder: (date, {secondaryDate}) => DateFormat.yMMMM().format(date),
      );
      buttonRow = Row(
        children: [
          ElevatedButton(
            onPressed: () => print("Not implemented"),
            child: const Text('<- Back'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          buttonRow!,
          Expanded(
            child: calendarView!,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed('/events');
          }
        },
      ),
    );
  }
}

final event = CalendarEventData(
  title: "Event 1",
  date: DateTime.now(),
  startTime: DateTime.now(),
  endTime: DateTime.now().add(const Duration(hours: 1)),
);

void a() {
  controller.add(event);
}
