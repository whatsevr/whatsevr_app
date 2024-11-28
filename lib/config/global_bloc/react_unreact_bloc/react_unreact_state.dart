part of 'react_unreact_bloc.dart';

// State
class ReactUnreactState extends Equatable {
  final Set<String> reactedItemIds;
  final bool isLoading;
  final String? error;

  const ReactUnreactState({
    required this.reactedItemIds,
    this.isLoading = false,
    this.error,
  });

  ReactUnreactState copyWith({
    Set<String>? reactedItemIds,
    bool? isLoading,
    String? error,
  }) {
    return ReactUnreactState(
      reactedItemIds: reactedItemIds ?? this.reactedItemIds,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [reactedItemIds, isLoading, error];
}
