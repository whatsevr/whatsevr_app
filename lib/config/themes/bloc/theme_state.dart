part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeType themeType;

  const ThemeState({
    required this.themeType,
  });

  ThemeState copyWith({
    ThemeType? themeType,
  }) {
    return ThemeState(
      themeType: themeType ?? this.themeType,
    );
  }

  @override
  List<Object?> get props => [themeType];
}
