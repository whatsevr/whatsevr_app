part of 'wtv_details_bloc.dart';

class WtvDetailsState extends Equatable {
  final String? videoPostUid;
  final String? thumbnail;
  final String? videoUrl;
  final VideoPostDetailsResponse? videoPostDetailsResponse;
  const WtvDetailsState({
    this.videoPostUid,
    this.thumbnail,
    this.videoUrl,
    this.videoPostDetailsResponse,
  });

  @override
  List<Object?> get props => [
        videoPostUid,
        thumbnail,
        videoUrl,
        videoPostDetailsResponse,
      ];

  WtvDetailsState copyWith({
    String? videoPostUid,
    String? thumbnail,
    String? videoUrl,
    VideoPostDetailsResponse? videoPostDetailsResponse,
  }) {
    return WtvDetailsState(
      videoPostUid: videoPostUid ?? this.videoPostUid,
      thumbnail: thumbnail ?? this.thumbnail,
      videoUrl: videoUrl ?? this.videoUrl,
      videoPostDetailsResponse:
          videoPostDetailsResponse ?? this.videoPostDetailsResponse,
    );
  }
}
