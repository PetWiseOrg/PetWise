import 'package:flutter/foundation.dart';
import 'package:petwise/data/repositories/pet_user_repo.dart';
import 'package:petwise/data/models/pet_user.dart';

class PetUserProvider extends ChangeNotifier {
  final PetUserRepository _petUserRepo;
  PetUser? _currentPetUser;

  PetUserProvider(this._petUserRepo);

  PetUser? get currentPetUser => _currentPetUser;

  Future<void> createPetUser(Map<String, dynamic> data) async {
    try {
      final petUserJson = await _petUserRepo.createPetUser(data);
      _currentPetUser = PetUser.fromJson(petUserJson);
      notifyListeners();
    } catch (e) {
      print('Error creating pet user: $e');
      rethrow;
    }
  }

  Future<void> loadPetUser(String userId) async {
    try {
      final petUserJson = await _petUserRepo.getPetUser(userId);
      _currentPetUser = PetUser.fromJson(petUserJson);
      notifyListeners();
    } catch (e) {
      print('Error loading pet user: $e');
      rethrow;
    }
  }

  Future<void> updatePetUser(String id, Map<String, dynamic> data) async {
    try {
      final petUserJson = await _petUserRepo.updatePetUser(id, data);
      _currentPetUser = PetUser.fromJson(petUserJson);
      notifyListeners();
    } catch (e) {
      print('Error updating pet user: $e');
      rethrow;
    }
  }

  Future<void> deletePetUser(String id) async {
    try {
      await _petUserRepo.deletePetUser(id);
      _currentPetUser = null;
      notifyListeners();
    } catch (e) {
      print('Error deleting pet user: $e');
      rethrow;
    }
  }
}
