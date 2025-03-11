import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  UserRepository._internal(this.pb);

  static UserRepository? _instance;
  static UserRepository getInstance(PocketBase pb) {
    _instance ??= UserRepository._internal(pb);
    return _instance!;
  }

  static UserRepository get instance => _instance!;

  final PocketBase pb;

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final record = await pb.collection('users').create(body: userData);
    return record.toJson();
  }

  Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> userData) async {
    final record = await pb.collection('users').update(userId, body: userData);
    return record.toJson();
  }

  Future<Map<String, dynamic>> updateUserProfile(String userId, Map<String, dynamic> userData, XFile? profileImage) async {
    List<http.MultipartFile> files = [];
    if (profileImage != null && profileImage.path.isNotEmpty) {
      files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          await profileImage.readAsBytes(),
          filename: '$userId-avatar.${profileImage.path.split('.').last}',
        ),
      );
    }
    final record = await pb.collection('users').update(userId, body: userData, files: files);
    return record.toJson();
  }

  Future<void> deleteUser(String userId) async {
    await pb.collection('users').delete(userId);
  }

  Future<Map<String, dynamic>> authenticateUser(String email, String password) async {
    final recordAuth = await pb.collection('users').authWithPassword(email, password);
    return recordAuth.toJson();
  }

  Future<void> requestPasswordReset(String email) async {
    await pb.collection('users').requestPasswordReset(email);
  }

  Future<void> verifyEmail(String token) async {
    await pb.collection('users').confirmVerification(token);
  }

  Future<bool> isUserAuthenticated() async {
    //return pb.authStore.isValid;
    //testing
    return false;
  }
}
