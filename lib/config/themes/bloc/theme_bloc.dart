import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeType: ThemeType.light)) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  AppTheme get currentTheme => _getThemeFromType(state.themeType);

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    final newThemeType =
        state.themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    emit(state.copyWith(themeType: newThemeType));
  }

  void _onSetTheme(SetThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeType: event.themeType));
  }

  AppTheme _getThemeFromType(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return LightTheme();
      case ThemeType.dark:
        return DarkTheme();
    }
  }
}
