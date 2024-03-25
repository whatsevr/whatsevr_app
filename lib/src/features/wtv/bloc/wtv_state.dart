part of 'wtv_bloc.dart';

sealed class WtvState extends Equatable {
  const WtvState();
}

final class WtvInitial extends WtvState {
  @override
  List<Object> get props => [];
}
