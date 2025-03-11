class VetUser {
  final String id;
  final String userId;
  final String? vetRole;
  final String? bio;
  final String? licenseNumber;
  final Map<String, dynamic>? preferences;

  VetUser({
    required this.id,
    required this.userId,
    this.vetRole,
    this.bio,
    this.licenseNumber,
    this.preferences,
  });

  factory VetUser.fromJson(Map<String, dynamic> json) {
    return VetUser(
      id: json['id'] ?? '',
      userId: json['user'] ?? '',
      vetRole: json['vetRole'],
      bio: json['bio'],
      licenseNumber: json['licenseNumber'],
      preferences: json['preferences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'vetRole': vetRole,
      'bio': bio,
      'licenseNumber': licenseNumber,
      'preferences': preferences,
    };
  }
}
