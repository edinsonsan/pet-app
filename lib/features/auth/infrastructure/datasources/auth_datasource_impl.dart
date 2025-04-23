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

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    
    try {
      final deviceName = await getDeviceName();

      final response = await dio.post('/login', data: {
        'email': email,
        'password': password,
        'device_name': deviceName
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
        throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}