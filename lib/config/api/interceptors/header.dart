import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

class ApiHeaderInterceptor extends Interceptor {
  static const List<String> _excludedRoutes = ['/auth/register', '/auth/login'];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      if (_excludedRoutes.any((route) => options.path.contains(route))) {
        handler.next(options);
        return;
      }

      // final String? token = AuthUserDb.getAuthToken();

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

      options.headers['authorization'] = 'Bearer XXXXXXXXXX';
      options.headers['x-user-auth-token'] = 'XXXXXXXXXXXXXX';
      options.headers['x-user-uid'] = userUid;
      
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

