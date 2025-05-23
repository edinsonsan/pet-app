import 'package:pet_app/features/auth/domain/domain.dart';
import 'package:pet_app/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl({AuthDataSource? datasource})
    : datasource = datasource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) {
    return datasource.register(fullName, email, password, confirmPassword);
  }

  @override
  Future<String> forgotPassword(String email) {
    return datasource.forgotPassword(email);
  }
}
