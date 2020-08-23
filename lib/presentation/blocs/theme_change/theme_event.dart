import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/datasource/app_themes.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]);
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({
    @required this.theme,
  });

  @override
  List<Object> get props => [];
}
