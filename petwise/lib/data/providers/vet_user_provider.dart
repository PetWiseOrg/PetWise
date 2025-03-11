import 'package:flutter/foundation.dart';
import 'package:petwise/data/repositories/vet_user_repo.dart';
import 'package:petwise/data/models/vet_user.dart';

class VetUserProvider extends ChangeNotifier {
  final VetUserRepository _vetUserRepo;
  VetUser? _currentVetUser;

  VetUserProvider(this._vetUserRepo);

  VetUser? get currentVetUser => _currentVetUser;

  Future<void> createVetUser(Map<String, dynamic> data) async {
    try {
      final vetUserJson = await _vetUserRepo.createVetUser(data);
      _currentVetUser = VetUser.fromJson(vetUserJson);
      notifyListeners();
    } catch (e) {
      print('Error creating vet user: $e');
      rethrow;
    }
  }

  Future<void> loadVetUser(String userId) async {
    try {
      final vetUserJson = await _vetUserRepo.getVetUser(userId);
      _currentVetUser = VetUser.fromJson(vetUserJson);
      notifyListeners();
    } catch (e) {
      print('Error loading vet user: $e');
      rethrow;
    }
  }

  Future<void> updateVetUser(String id, Map<String, dynamic> data) async {
    try {
      final vetUserJson = await _vetUserRepo.updateVetUser(id, data);
      _currentVetUser = VetUser.fromJson(vetUserJson);
      notifyListeners();
    } catch (e) {
      print('Error updating vet user: $e');
      rethrow;
    }
  }

  Future<void> deleteVetUser(String id) async {
    try {
      await _vetUserRepo.deleteVetUser(id);
      _currentVetUser = null;
      notifyListeners();
    } catch (e) {
      print('Error deleting vet user: $e');
      rethrow;
    }
  }
}
