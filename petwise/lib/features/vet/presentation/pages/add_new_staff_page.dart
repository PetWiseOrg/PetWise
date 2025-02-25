import 'package:flutter/material.dart';


class AddNewStaffPage extends StatefulWidget {
  const AddNewStaffPage({Key? key}) : super(key: key);

  @override
  _AddNewStaffPageState createState() => _AddNewStaffPageState();
}



class _AddNewStaffPageState extends State<AddNewStaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Staff'),
      ),
      body: const Center(
        child: Column(
          children:  <Widget>[
            SizedBox(height: 20),
            Text(
              'Add New Staff',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Name:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Role:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Password:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Confirm Password:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: null,
              child: Text('Add Staff'),
            ),
          ],
        ),
      ),
    );
  }
}