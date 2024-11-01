part of 'react_unreact_bloc.dart';

abstract class ReactUnreactEvent extends Equatable {
  const ReactUnreactEvent();

  @override
  List<Object?> get props => [];
}

class FetchReactions extends ReactUnreactEvent {}

class ToggleReaction extends ReactUnreactEvent {
  final String? reactionType;
  final String? videoPostUid;
  final String? flickPostUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? photoPostUid;
  final String? pdfUid;

  const ToggleReaction({
    this.reactionType,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
  });

  @override
  List<Object?> get props => [
        reactionType,
        videoPostUid,
        flickPostUid,
        memoryUid,
        offerPostUid,
        photoPostUid,
        pdfUid,
      ];
}
