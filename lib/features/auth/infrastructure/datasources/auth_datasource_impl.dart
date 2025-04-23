import 'dart:io';

import 'package:pet_app/config/config.dart';
import 'package:pet_app/features/auth/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:pet_app/features/auth/infrastructure/infrastructure.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthDataSourceImpl extends AuthDataSource {
  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return '${iosInfo.name} ${iosInfo.model}';
    } else {
      return 'Unknown Device';
    }
  }

  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final deviceName = await getDeviceName();

      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password, 'device_name': deviceName},
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Credenciales incorrectas',
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await dio.post(
        '/register',
        data: {
          'name': fullName,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final data = e.response?.data;
        if (data != null && data['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;

          // Recolectamos todos los mensajes de error en una lista
          final errorMessages =
              errors.entries
                  .expand(
                    (entry) =>
                        (entry.value as List).map((msg) => msg.toString()),
                  )
                  .toList();

          // Los unimos en un solo string separados por saltos de línea
          final fullMessage = errorMessages.join('\n');

          throw CustomError(fullMessage);
        }

        throw CustomError('Datos inválidos');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar Conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> forgotPassword(String email) async {
    try {
      final response = await dio.post('/set-password', data: {'email': email});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Email Incorrecto');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
