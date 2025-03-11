import 'package:flutter/material.dart';
import 'package:petwise/data/repositories/user_repo.dart';
import 'package:petwise/data/models/user.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  final UserRepository _userRepo;

  AuthProvider(this._userRepo);

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      final userJson = await _userRepo.createUser(userData);
      _currentUser = User.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      final userJson = await _userRepo.updateUser(userId, userData);
      _currentUser = User.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> refreshCurrentUser() async {
    try {
      final userJson = await _userRepo.refreshCurrentUser();
      _currentUser = User.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Error refreshing current user: $e');
      rethrow;
    }
  }

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> userData, XFile profileImage) async {
    try {
      final userJson =
          await _userRepo.updateUserProfile(userId, userData, profileImage);
      _currentUser = User.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  Future<void> verifyUser(String userId) async {
    try {
      await updateUser(userId, {'verified': true});
    } catch (e) {
      print('Error verifying user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _userRepo.deleteUser(userId);
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  Future<void> authenticateUser(String email, String password) async {
    try {
      final userJson = await _userRepo.authenticateUser(email, password);
      _currentUser = User.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Error authenticating user: $e');
      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await _userRepo.requestPasswordReset(email);
    } catch (e) {
      print('Error requesting password reset: $e');
      rethrow;
    }
  }

  //send verification email
  Future<void> sendVerificationEmail(String email) async {
    try {
      await _userRepo.sendVerificationEmail(email);
    } catch (e) {
      print('Error sending verification email: $e');
      rethrow;
    }
  }

  Future<void> verifyEmail(String token) async {
    try {
      await _userRepo.verifyEmail(token);
    } catch (e) {
      print('Error verifying email: $e');
      rethrow;
    }
  }

  Future<bool> isUserAuthenticated() async {
    try {
      final isValid = await _userRepo.isUserAuthenticated();
      return isValid;
    } catch (e) {
      print('Error checking user authentication: $e');
      return false;
    }
  }
  Future<bool> isUserFullyCreated(String userId) async {
    try {
      //refresh current user
      await refreshCurrentUser();
      //check if user is fully created
      final isFullyCreated = _currentUser!.isFullyCreated;
      return isFullyCreated;

    } catch (e) {
      print('Error checking user authentication: $e');
      return false;
    }
  }
}
