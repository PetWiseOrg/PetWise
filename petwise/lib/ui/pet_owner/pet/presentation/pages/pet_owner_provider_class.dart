import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetOwnerProvider extends ChangeNotifier {
  PetOwner _petOwner = PetOwner(name: "John Doe", address: "123 Pet Street", pets: []);

  PetOwner get petOwner => _petOwner;

  void updatePetOwner(PetOwner petOwner) {
    _petOwner = petOwner;
    notifyListeners();
  }

  void addPet(Pet pet) {
    _petOwner.pets.add(pet);
    notifyListeners();
  }

  void updatePet(int index, Pet updatedPet) {
    _petOwner.pets[index] = updatedPet;
    notifyListeners();
  }
}

class Pet {
  XFile? profileImage; // Add this variable
  String name;
  int age;
  double weight;
  String species;
  String breed;

  Pet({this.profileImage, required this.name, required this.age, required this.weight, required this.species, required this.breed});
}

class PetOwner {
  XFile? profileImage; // Add this variable
  String name;
  String address;
  List<Pet> pets;

  PetOwner({this.profileImage, required this.name, required this.address, required this.pets});
}
