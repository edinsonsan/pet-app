import 'package:pet_app/config/config.dart';
import 'package:pet_app/src/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:pet_app/src/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String fullName, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
