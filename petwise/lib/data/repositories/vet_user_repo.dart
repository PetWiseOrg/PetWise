import 'package:pocketbase/pocketbase.dart';

class VetUserRepository {
  VetUserRepository._internal(this.pb);

  static VetUserRepository? _instance;
  static VetUserRepository getInstance(PocketBase pb) {
    _instance ??= VetUserRepository._internal(pb);
    return _instance!;
  }

  static VetUserRepository get instance => _instance!;

  final PocketBase pb;

  Future<Map<String, dynamic>> createVetUser(Map<String, dynamic> data) async {
    final record = await pb.collection('vetUsers').create(body: data);
    return record.toJson();
  }

  Future<Map<String, dynamic>> getVetUser(String userId) async {
    final record = await pb.collection('vetUsers').getFirstListItem('user="$userId"');
    return record.toJson();
  }

  Future<Map<String, dynamic>> updateVetUser(String id, Map<String, dynamic> data) async {
    final record = await pb.collection('vetUsers').update(id, body: data);
    return record.toJson();
  }

  Future<void> deleteVetUser(String id) async {
    await pb.collection('vetUsers').delete(id);
  }
}
