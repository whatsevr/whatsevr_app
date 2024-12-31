import 'dart:convert';

class WhatsevrNetworkFile {
  final String? type;
  final String? videoUrl;
  final int? videoDurationMs;
  final String? videoThumbnailUrl;
  final String? imageUrl;

  WhatsevrNetworkFile({
    this.type,
    this.videoUrl,
    this.videoDurationMs,
    this.videoThumbnailUrl,
    this.imageUrl,
  });

  WhatsevrNetworkFile copyWith({
    String? type,
    String? videoUrl,
    int? videoDurationMs,
    String? videoThumbnailUrl,
    String? imageUrl,
  }) =>
      WhatsevrNetworkFile(
        type: type ?? this.type,
        videoUrl: videoUrl ?? this.videoUrl,
        videoDurationMs: videoDurationMs ?? this.videoDurationMs,
        videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory WhatsevrNetworkFile.fromJson(String str) =>
      WhatsevrNetworkFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WhatsevrNetworkFile.fromMap(Map<String, dynamic> json) =>
      WhatsevrNetworkFile(
        type: json['type'],
        videoUrl: json['video_url'],
        videoDurationMs: json['video_duration_ms'],
        videoThumbnailUrl: json['video_thumbnail_url'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'video_url': videoUrl,
        'video_duration_ms': videoDurationMs,
        'video_thumbnail_url': videoThumbnailUrl,
        'image_url': imageUrl,
      };
}
