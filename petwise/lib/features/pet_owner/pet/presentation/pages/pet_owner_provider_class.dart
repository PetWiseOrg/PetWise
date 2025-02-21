import 'package:flutter/material.dart';

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
  String name;
  int age;
  double weight;
  String species;
  String breed;

  Pet({required this.name, required this.age, required this.weight, required this.species, required this.breed});
}

class PetOwner {
  String name;
  String address;
  List<Pet> pets;

  PetOwner({required this.name, required this.address, required this.pets});
}
