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
