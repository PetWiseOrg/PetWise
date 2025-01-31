class User {
  final String id;
  final String email;
  final String username;
  final DateTime? lastLogin;
  final String? phoneNumber;
  final bool verified;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.lastLogin,
    this.phoneNumber,
    this.verified = false,
    this.avatar,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    final record = json['record'] ?? {};
    return User(
      id: record['id'] ?? '',
      email: record['email'] ?? '',
      username: record['username'] ?? '',
      lastLogin: record['lastLogin'] != null && record['lastLogin'] != ''
          ? DateTime.parse(record['lastLogin'])
          : null,
      phoneNumber: record['phoneNumber'],
      verified: record['verified'] ?? false,
      avatar: record['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'lastLogin': lastLogin?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'verified': verified,
      'avatar': avatar,
    };
  }
}
