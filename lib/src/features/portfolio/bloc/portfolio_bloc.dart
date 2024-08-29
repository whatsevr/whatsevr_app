import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(AccountInitial()) {
    on<PortfolioEvent>((PortfolioEvent event, Emitter<PortfolioState> emit) {
      // TODO: implement event handler
    });
  }
}
