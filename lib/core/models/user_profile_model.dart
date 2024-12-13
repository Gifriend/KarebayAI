class UserProfileModel {
  final String userName;
  final String email;
  final String profilePic;
  final String userId;
  UserProfileModel({
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': userName,
      'email': email,
      'profilePic': profilePic,
      'userId': userId,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      userName: map['username'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      userId: map['userId'] as String,
    );
  }

  // String tojson() => jsonEncode(toMap());

  // factory UserModel.fromJson(String source) =>
  // UserModel.fromMap(jsonDecode(source) as Map <String, dynamic>);
}
