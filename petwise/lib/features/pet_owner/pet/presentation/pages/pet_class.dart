import 'package:flutter/material.dart';

class Pet {
  String name;
  int age;
  double weight;

  Pet({required this.name, required this.age, required this.weight});
}

class EditPetPage extends StatelessWidget {
  const EditPetPage({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit ${pet.name}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(initialValue: pet.name, decoration: const InputDecoration(labelText: "Pet Name")),
            TextFormField(initialValue: pet.age.toString(), decoration: const InputDecoration(labelText: "Age")),
            TextFormField(initialValue: pet.weight.toString(), decoration: const InputDecoration(labelText: "Weight")),
            const SizedBox(height: 20),

            ElevatedButton(onPressed: () {}, child: Text("Save Changes")),
          ],
        ),
      ),
    );
  }
}

class PetOwner {
  String name;
  String address;
  List<Pet> pets;

  PetOwner({required this.name, required this.address, required this.pets});
}
