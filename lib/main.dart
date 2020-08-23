import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wallpaper_app/data/repositories/photos_repository_impl.dart';
import 'package:wallpaper_app/domain/usecases/api_provider.dart';
import 'package:wallpaper_app/presentation/blocs/fetch_trends/fetch_trends_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/search/search_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/theme_change/bloc.dart';
import 'package:wallpaper_app/presentation/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
//  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
            create: (context) =>
                SearchBloc(PhotosRepositoryImpl(APIProvider()))),
//        BlocProvider<ThemeChangeBloc>(create: (context) => ThemeChangeBloc()),
        BlocProvider<FetchTrendsBloc>(
            create: (context) =>
                FetchTrendsBloc(PhotosRepositoryImpl(APIProvider()))),
      ],
      child: BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, state) {
            return MaterialApp(
              title: 'WallpaperHub',
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              home: Home(),
            );
          },
        ),
      ),
    );
  }
}
