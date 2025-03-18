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

  @override
  void initState() {
    super.initState();
    monthView(selectedDate);
  }

  void dayView(DateTime date) {
    selectedDate = date;
    setState(() {
      calendarView = DayView(
        controller: controller,
        initialDay: selectedDate,
        headerStyle: headerStyle,
        onPageChange: (date, page) => selectedDate = date,
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
    selectedDate = date;
    setState(() {
      calendarView = WeekView(
        controller: controller,
        initialDay: selectedDate,
        startDay: WeekDays.sunday,
        onPageChange: (date, page) => selectedDate = date,
        headerStyle: headerStyle,
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
    selectedDate = date;
    setState(() {
      calendarView = MonthView(
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
        initialMonth: selectedDate,
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => selectedDate = date,
        onCellTap: (events, date) => dayView(date),
        startDay: WeekDays.sunday, // To change the first day of the week.
        // This callback will only work if cellBuilder is null.
        onEventTap: (event, date) => print(event),
        onEventDoubleTap: (events, date) => print(events),
        onEventLongTap: (event, date) => print(event),
        onDateLongPress: (date) => print(date),
        showWeekTileBorder: false, // To hide header border
        hideDaysNotInMonth: true, // To hide days or cell that are not in current month
        useAvailableVerticalSpace: true,
        headerStyle: headerStyle,
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
          //   const Text('Debug Buttons:'),
          //   Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //     ElevatedButton(
          //       onPressed: () => monthView(DateTime.now()),
          //       child: const Text('Month View'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () => weekView(DateTime.now()),
          //       child: const Text('Week View'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () => dayView(DateTime.now()),
          //       child: const Text('Day View'),
          //     ),
          //   ]),
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
