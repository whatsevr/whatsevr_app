part of 'wtv_details_bloc.dart';

sealed class WtvDetailsState extends Equatable {
  const WtvDetailsState();
}

final class WtvDetailsInitial extends WtvDetailsState {
  @override
  List<Object> get props => [];
}
