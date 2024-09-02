import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiCacheInterceptor extends DioCacheInterceptor {
  ApiCacheInterceptor()
      : super(
            options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          hitCacheOnErrorExcept: [
            HttpStatus.unauthorized,
            HttpStatus.forbidden,
          ],
          maxStale: const Duration(minutes: 3),
          priority: CachePriority.normal,
          cipher: null,
          keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          allowPostMethod: false,
        ));
}
