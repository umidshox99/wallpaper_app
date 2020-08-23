import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wallpaper_app/data/datasource/app_themes.dart';

import './bloc.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: appThemeData[AppTheme.Light], appTheme: AppTheme.Light));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(
          themeData: appThemeData[event.theme], appTheme: event.theme);
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(
          themeData: appThemeData[
              EnumToString.fromString(AppTheme.values, json['theme'])],
          appTheme: EnumToString.fromString(AppTheme.values, json['theme']));
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    try {
      return {'theme': EnumToString.parse(state.appTheme)};
    } catch (_) {
      return null;
    }
  }
}
