part of 'wtv_details_bloc.dart';

sealed class WtvDetailsEvent extends Equatable {
  const WtvDetailsEvent();
}

class InitialEvent extends WtvDetailsEvent {
  final WtvDetailsPageArgument pageArgument;

  const InitialEvent(this.pageArgument);

  @override
  List<Object> get props => [pageArgument];
}

class FetchVideoPostDetails extends WtvDetailsEvent {
  final String? videoPostUid;
  final String? thumbnail;
  final String? videoUrl;
  const FetchVideoPostDetails({
    this.videoPostUid,
    this.thumbnail,
    this.videoUrl,
  });

  @override
  List<Object?> get props => [
        videoPostUid,
        thumbnail,
        videoUrl,
      ];
}
