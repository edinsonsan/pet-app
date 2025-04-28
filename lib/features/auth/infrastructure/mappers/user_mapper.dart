import 'package:pet_app/features/auth/domain/domain.dart';

// class UserMapper {
//   static User userJsonToEntity(Map<String, dynamic> json) => User(
//     id: json['id'],
//     email: json['email'],
//     fullName: json['fullName'],
//     roles: List<String>.from(json['roles'].map((role)=>role)),
//     token: json['token'],
//   );
// }
class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    final userData = json['user'];
    return User(
      id: userData['id'].toString(),
      name: userData['name'],
      email: userData['email'],
      googleId: userData['google_id'],
      profilePhoto: userData['profile_photo'],
      emailVerifiedAt:
          userData['email_verified_at'] != null
              ? DateTime.tryParse(userData['email_verified_at'])
              : null,
      createdAt: DateTime.parse(userData['created_at']),
      updatedAt: DateTime.parse(userData['updated_at']),
      // roles: List<String>.from(json['roles'].map((role)=>role)),
      token: json['token'],
      message: json['message'],
    );
  }


  static String resetPasswordMessage(Map<String, dynamic> json) {
    return json['message']; // Solo devuelve el mensaje
  }

  
}


