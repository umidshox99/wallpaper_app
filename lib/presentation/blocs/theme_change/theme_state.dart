import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/datasource/app_themes.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  final AppTheme appTheme;

  ThemeState({@required this.themeData, @required this.appTheme});

  @override
  List<Object> get props => [themeData, appTheme];
}
