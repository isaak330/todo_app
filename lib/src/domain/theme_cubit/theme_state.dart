part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class LightThemeState extends ThemeState {}

final class DarkThemeState extends ThemeState {}
