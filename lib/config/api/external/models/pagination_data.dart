import 'package:equatable/equatable.dart';

class PaginationData extends Equatable {
  final int currentPage;
  final bool isLoading;
  final bool noMoreData;

  const PaginationData({
    this.currentPage = 1,
    this.isLoading = false,
    this.noMoreData = false,
  });

  @override
  List<Object?> get props => <Object?>[currentPage, isLoading, noMoreData];

  PaginationData copyWith({
    int? currentPage,
    bool? isLoading,
    bool? isLastPage,
  }) {
    return PaginationData(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      noMoreData: isLastPage ?? noMoreData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'isLoading': isLoading,
      'noMoreData': noMoreData,
    };
  }
}
