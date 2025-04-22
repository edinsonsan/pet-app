import 'package:pet_app/src/domain/domain.dart';
import 'package:pet_app/src/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(AuthDatasource? datasource)
    : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String fullName, String email, String password) {
    return datasource.register(fullName, email, password);
  }
}
