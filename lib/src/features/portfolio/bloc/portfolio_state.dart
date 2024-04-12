part of 'portfolio_bloc.dart';

sealed class PortfolioState extends Equatable {
  const PortfolioState();
}

final class AccountInitial extends PortfolioState {
  @override
  List<Object> get props => [];
}
