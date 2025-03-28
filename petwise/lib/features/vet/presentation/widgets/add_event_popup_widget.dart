import 'package:flutter/material.dart';
class AddEventPopupWidget extends StatefulWidget{

  const AddEventPopupWidget({super.key});

  @override
  _AddEventPopupWidgetState createState() => _AddEventPopupWidgetState();


}

class _AddEventPopupWidgetState extends State<AddEventPopupWidget>{
  
    DateTime? _startDateTime;
    DateTime? _endDateTime;
  
    @override
    void initState() {
      super.initState();
      _startDateTime = DateTime.now();
      _endDateTime = DateTime.now().add(const Duration(hours: 1));
    }
  
    @override
    Widget build(BuildContext context) {
      return {
      

    }
}
// Open a menu from the bottom of the screen when clicked
void showBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the form
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Text('New Event', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 40),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Event Name',
                        ),
                        maxLines: null,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Event Description',
                        ),
                        maxLines: null,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: EventStartAndEndTimesWidget(),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
