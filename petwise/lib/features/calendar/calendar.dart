import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

var controller = EventController();

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: MonthView(
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
        initialMonth: DateTime(2025, 2),
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) => print(events),
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

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return const Calendar();
  }
}

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthView(
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
        initialMonth: DateTime(2025, 2),
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) => print(events),
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
