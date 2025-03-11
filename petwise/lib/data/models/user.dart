class User {
  final String id;
  final String email;
  final String username;
  final String userType;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? avatar;
  final DateTime? lastLogin;
  final bool verified;
  final bool isFullyCreated;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.userType,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.avatar,
    this.lastLogin,
    this.verified = false,
    this.isFullyCreated = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final record = json['record'] ?? json;
    return User(
      id: record['id'] ?? '',
      email: record['email'] ?? '',
      username: record['username'] ?? '',
      userType: record['userType'] ?? 'petUser',
      firstName: record['firstName'] ?? '',
      lastName: record['lastName'] ?? '',
      phoneNumber: record['phoneNumber'],
      avatar: record['avatar'],
      lastLogin: record['lastLogin'] != null && record['lastLogin'] != '' ? DateTime.parse(record['lastLogin']) : null,
      verified: record['verified'] ?? false,
      isFullyCreated: record['isFullyCreated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'lastLogin': lastLogin?.toIso8601String(),
      'verified': verified,
      'isFullyCreated': isFullyCreated,
    };
  }
}
