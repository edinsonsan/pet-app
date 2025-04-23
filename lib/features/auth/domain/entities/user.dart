class User {
  final String id;
  final String name;
  final String email;
  final String? googleId;
  final String? profilePhoto;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final List<String> roles;
  final String token;
  final String? message;


  User({
    required this.id,
    required this.name,
    required this.email,
    this.googleId,
    this.profilePhoto,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    // required this.roles,
    required this.token,
    this.message,
  });
  
  // bool get isAdmin {
  //   return roles.contains('admin');
  // } 

}
