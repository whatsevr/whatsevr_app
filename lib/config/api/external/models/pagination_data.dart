import 'package:equatable/equatable.dart';

class PaginationData extends Equatable {
  final int currentVideoPage;
  final bool isLoading;
  final bool isLastPage;

  const PaginationData({
    required this.currentVideoPage,
    required this.isLoading,
    required this.isLastPage,
  });

  @override
  List<Object?> get props => <Object?>[currentVideoPage, isLoading, isLastPage];

  PaginationData copyWith({
    int? currentVideoPage,
    bool? isLoading,
    bool? isLastPage,
  }) {
    return PaginationData(
      currentVideoPage: currentVideoPage ?? this.currentVideoPage,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
