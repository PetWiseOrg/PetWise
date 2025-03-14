import 'package:flutter/material.dart';


class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({super.key});

  @override
  AddNewEventPageState createState() => AddNewEventPageState();


}

class AddNewEventPageState extends State<AddNewEventPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: const Center(
        child: Text('Add New Event.'),
      ),

    );
  }
}