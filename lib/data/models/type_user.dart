import 'dart:convert';

class TypeUser {
  final String userId;
  final String userEmail;
  TypeUser({
    required this.userId,
    required this.userEmail,
  });

  TypeUser copyWith({
    String? userId,
    String? userEmail,
  }) {
    return TypeUser(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
    };
  }

  factory TypeUser.fromMap(Map<String, dynamic> map) {
    return TypeUser(
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUser.fromJson(String source) =>
      TypeUser.fromMap(json.decode(source));

  @override
  String toString() => 'TypeUser(userId: $userId, userEmail: $userEmail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeUser &&
        other.userId == userId &&
        other.userEmail == userEmail;
  }

  @override
  int get hashCode => userId.hashCode ^ userEmail.hashCode;
}
