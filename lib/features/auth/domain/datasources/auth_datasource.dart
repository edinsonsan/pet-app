
import 'package:pet_app/features/auth/domain/domain.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password, String confirmPassword);
  Future<User> checkAuthStatus(String token);
  Future<User> forgotPassword(String email);
}