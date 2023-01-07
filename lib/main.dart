import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/layout/home_layout_screen.dart';
import 'package:movies/shared/bloc_observer.dart';
import 'package:movies/shared/styles/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'models/movie.dart';
import 'modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MovieAdapter());
  await Hive.initFlutter();
  Bloc.observer = MoviesBlocObserver();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {

  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()
        ..getUpcomingMovies()
        ..getNowPlayingMovies()
        ..getGenresList()
        ..getCategoryMovies(categoryId: 28)
        ..getBox()..getTrendingMovies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
        home: AnimatedSplashScreen(
          splashIconSize: 130,
          duration: 4000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.grey.shade900,
          nextScreen: const HomeLayoutScreen(),
          splash: SvgPicture.asset(
            'assets/images/popcorn-svgrepo-com.svg',
            height: 182,
            width: 147,
            alignment: AlignmentDirectional.center,
          ),
        ),
      ),
    );
  }
}
