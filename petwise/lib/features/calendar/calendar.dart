import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

var controller = EventController();

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Widget? child;

  @override
  void initState() {
    super.initState();
    monthView(DateTime.now());
  }

  void dayView(DateTime date) {
    setState(() {
      child = DayView(
        controller: controller,
        minDay: DateTime(2025),
        maxDay: DateTime(2050),
        initialDay: date,
      );
    });
  }

  void weekView() {
    setState(() {
      child = const WeekView();
    });
  }

  void monthView(DateTime date) {
    setState(() {
      child = MonthView(
        controller: controller,
        // cellBuilder: (
        //   date,
        //   events,
        //   isToday,
        //   isInMonth,
        //   hideDaysNotInMonth,
        // ) {
        //   // Return your widget to display as month cell.
        //   return Container();
        // },
        minMonth: DateTime(2025),
        maxMonth: DateTime(2050),
        initialMonth: date,
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) => dayView(date),
        startDay: WeekDays.sunday, // To change the first day of the week.
        // This callback will only work if cellBuilder is null.
        onEventTap: (event, date) => print(event),
        onEventDoubleTap: (events, date) => print(events),
        onEventLongTap: (event, date) => print(event),
        onDateLongPress: (date) => print(date),
        // headerBuilder: MonthHeader.hidden, // To hide month header
        showWeekTileBorder: true, // To show or hide header border
        hideDaysNotInMonth: true, // To hide days or cell that are not in current month
        useAvailableVerticalSpace: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: child,
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
