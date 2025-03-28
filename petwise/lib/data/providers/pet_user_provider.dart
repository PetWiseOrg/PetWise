import 'package:flutter/foundation.dart';
import 'package:petwise/data/repositories/pet_user_repo.dart';
import 'package:petwise/data/models/pet_user.dart';

class PetUserProvider extends ChangeNotifier {
  final PetUserRepository _petUserRepo;
  PetUser? _currentPetUser;
  bool _isLoading = false;
  String? _error;

  PetUserProvider(this._petUserRepo);

  PetUser? get currentPetUser => _currentPetUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> createPetUser(Map<String, dynamic> data) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final petUserJson = await _petUserRepo.createPetUser(data);
      _currentPetUser = PetUser.fromJson(petUserJson);
      _error = null;
    } catch (e) {
      _error = 'Error creating pet user: $e';
      print(_error);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loadPetUser(String userId) async {
    if (userId.isEmpty) {
      _error = 'Cannot load pet user: User ID is empty';
      notifyListeners();
      return false;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // First check if the pet user exists
      final exists = await _petUserRepo.petUserExists(userId);

      if (!exists) {
        // Pet user doesn't exist - this is not an error, just return false
        _currentPetUser = null;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final petUserJson = await _petUserRepo.getPetUser(userId);

      if (petUserJson == null) {
        _currentPetUser = null;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentPetUser = PetUser.fromJson(petUserJson);
      _error = null;
      return true;
    } catch (e) {
      _error = 'Error loading pet user: $e';
      print(_error);
      _currentPetUser = null;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePetUser(String id, Map<String, dynamic> data) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final petUserJson = await _petUserRepo.updatePetUser(id, data);
      _currentPetUser = PetUser.fromJson(petUserJson);
      _error = null;
    } catch (e) {
      _error = 'Error updating pet user: $e';
      print(_error);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePetUser(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _petUserRepo.deletePetUser(id);
      _currentPetUser = null;
      _error = null;
    } catch (e) {
      _error = 'Error deleting pet user: $e';
      print(_error);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to ensure a pet user exists for the current user
  Future<PetUser?> ensurePetUserExists(String userId, {String homeAddress = ''}) async {
    if (userId.isEmpty) {
      _error = 'Cannot ensure pet user: User ID is empty';
      notifyListeners();
      return null;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // First check: Do we already have the pet user loaded?
      if (_currentPetUser != null && _currentPetUser!.userId == userId) {
        print('Returning already loaded pet user for $userId');
        _isLoading = false;
        notifyListeners();
        return _currentPetUser;
      }

      // Second check: Does the pet user exist in the database?
      final exists = await _petUserRepo.petUserExists(userId);
      print('Pet user exists check for $userId: $exists');

      if (exists) {
        // If it exists, load it
        final petUserJson = await _petUserRepo.getPetUser(userId);
        if (petUserJson != null) {
          _currentPetUser = PetUser.fromJson(petUserJson);
          _isLoading = false;
          notifyListeners();
          return _currentPetUser;
        }
      }

      // If we get here, we need to create a new pet user
      print('Creating new pet user for $userId');
      final petUserData = {
        'user': userId,
        'homeAddress': homeAddress,
        'pets': [],
      };

      try {
        final petUserJson = await _petUserRepo.createPetUser(petUserData);
        _currentPetUser = PetUser.fromJson(petUserJson);
        _isLoading = false;
        notifyListeners();
        return _currentPetUser;
      } catch (createError) {
        // If creation fails, try one more time to load - maybe it was created in another thread
        print('Creation failed, trying one more load: $createError');
        final petUserJson = await _petUserRepo.getPetUser(userId);
        if (petUserJson != null) {
          _currentPetUser = PetUser.fromJson(petUserJson);
          _isLoading = false;
          notifyListeners();
          return _currentPetUser;
        }

        throw createError; // If we still can't find it, rethrow the original error
      }
    } catch (e) {
      _error = 'Error ensuring pet user: $e';
      print(_error);
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
