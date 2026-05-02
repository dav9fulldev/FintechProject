class UserModel {
  final int id;
  final String? firstName;
  final String email;
  final String username;
  final String? phone;
  final bool isActive;
  final DateTime createdAt;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.email,
    required this.username,
    required this.phone,
    required this.isActive,
    required this.createdAt,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'] ?? json['firstName'],
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'email': email,
      'username': username,
      'phone': phone,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'profile_picture': profilePicture,
    };
  }

  UserModel copyWith({
    int? id,
    String? firstName,
    String? email,
    String? username,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
