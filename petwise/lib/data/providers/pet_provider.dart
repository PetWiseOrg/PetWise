import 'package:flutter/foundation.dart';
import 'package:petwise/data/repositories/pet_repo.dart';
import 'package:petwise/data/models/pet.dart';

class PetProvider extends ChangeNotifier {
  final PetRepository _petRepo;
  List<Pet> _pets = [];

  PetProvider(this._petRepo);

  List<Pet> get pets => _pets;

  Future<void> createPet(Map<String, dynamic> data) async {
    try {
      final petJson = await _petRepo.createPet(data);
      final pet = Pet.fromJson(petJson);
      _pets.add(pet);
      notifyListeners();
    } catch (e) {
      print('Error creating pet: $e');
      rethrow;
    }
  }

  Future<void> loadPets(String userId) async {
    try {
      final petsJson = await _petRepo.getPetsByUser(userId);
      _pets = petsJson.map((json) => Pet.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading pets: $e');
      rethrow;
    }
  }

  Future<void> updatePet(String id, Map<String, dynamic> data) async {
    try {
      final petJson = await _petRepo.updatePet(id, data);
      final petIndex = _pets.indexWhere((pet) => pet.id == id);
      if (petIndex != -1) {
        _pets[petIndex] = Pet.fromJson(petJson);
        notifyListeners();
      }
    } catch (e) {
      print('Error updating pet: $e');
      rethrow;
    }
  }

  Future<void> deletePet(String id) async {
    try {
      await _petRepo.deletePet(id);
      _pets.removeWhere((pet) => pet.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting pet: $e');
      rethrow;
    }
  }
}
