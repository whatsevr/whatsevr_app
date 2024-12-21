import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

class ApiHeaderInterceptor extends Interceptor {
  static const List<String> _excludedRoutes = ['/auth/register', '/auth/login'];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      options.headers['authorization'] = 
      
      'Bearer ZSLBTlLJf8yrOAojKmcYQTyA6aS4WK3Quv1yCWGU1rI/6VAQIh8y';
      if (_excludedRoutes.any((route) => options.path.contains(route))) {
        handler.next(options);
        return;
      }

     

      final String? userUid = AuthUserDb.getLastLoggedUserUid();

      if (userUid == null) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.unknown,
            error: 'User authentication required',
          ),
        );
        return;
      }

      
      options.headers['x-user-jwt-token'] = userUid;
      
      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: 'Error setting request headers: $e',
        ),
      );
    }
  }
}

