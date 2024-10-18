part of 'wtv_details_bloc.dart';

class WtvDetailsState extends Equatable {
  final String? videoPostUid;
  final String? thumbnail;
  final String? videoUrl;

  const WtvDetailsState({
    this.videoPostUid,
    this.thumbnail,
    this.videoUrl,
  });

  @override
  List<Object?> get props => [videoPostUid, thumbnail, videoUrl];

  WtvDetailsState copyWith({
    String? videoPostUid,
    String? thumbnail,
    String? videoUrl,
  }) {
    return WtvDetailsState(
      videoPostUid: videoPostUid ?? this.videoPostUid,
      thumbnail: thumbnail ?? this.thumbnail,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
