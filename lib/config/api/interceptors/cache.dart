import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class ApiCacheInterceptor extends DioCacheInterceptor {
  ApiCacheInterceptor({
    required String cacheDirectoryPath,
  }) : super(
            options: CacheOptions(
          store: HiveCacheStore(cacheDirectoryPath),
          policy: CachePolicy.request,
          hitCacheOnErrorExcept: <int>[
            HttpStatus.unauthorized,
            HttpStatus.forbidden,
          ],
          maxStale: const Duration(minutes: 3),
          priority: CachePriority.normal,
          cipher: null,
          keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          allowPostMethod: false,
        ),);
}
