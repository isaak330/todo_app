import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/src/data/db/theme_db.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState());

  void init() {
    ThemeDb.getTheme().then((theme) {
      emit(theme == 'light' ? LightThemeState() : DarkThemeState());
    });
  }

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
      ThemeDb.saveTheme(ThemeDb.darkTheme);
    } else {
      emit(LightThemeState());
      ThemeDb.saveTheme(ThemeDb.lightTheme);
    }
  }
}
