
import 'package:pet_app/src/domain/domain.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password);
  Future<User> checkAuthStatus(String token);
}