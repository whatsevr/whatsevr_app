import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class ApiCacheInterceptor extends DioCacheInterceptor {
  ApiCacheInterceptor({
    required String? cacheDirectoryPath,
    required int? maxMinuteOnDevice,
    required bool? cachePostRequest,
  }) : super(
          options: CacheOptions(
            store: HiveCacheStore(
              cacheDirectoryPath,
              hiveBoxName: 'api_cache_747',
            ),
            policy: CachePolicy.request,
            hitCacheOnErrorExcept: <int>[
              HttpStatus.unauthorized,
              HttpStatus.forbidden,
            ],
            maxStale: Duration(minutes: maxMinuteOnDevice ?? 1),
            priority: CachePriority.normal,
            cipher: null,
            keyBuilder: CacheOptions.defaultCacheKeyBuilder,
            allowPostMethod: cachePostRequest ?? false,
          ),
        );
}
