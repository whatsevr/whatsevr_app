import 'package:equatable/equatable.dart';

class PaginationData extends Equatable {
  final int currentPage;
  final bool isLoading;
  final bool noMoreData;

  const PaginationData({
    required this.currentPage,
    required this.isLoading,
    required this.noMoreData,
  });

  @override
  List<Object?> get props => <Object?>[currentPage, isLoading, noMoreData];

  PaginationData copyWith({
    int? currentPage,
    bool? isLoading,
    bool? noMoreData,
  }) {
    return PaginationData(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      noMoreData: noMoreData ?? this.noMoreData,
    );
  }
}