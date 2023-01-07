import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/shared/network/remote/api_constance.dart';
import '../../../models/movie.dart';
import '../../../shared/styles/app_strings.dart';
import '../../../shared/styles/iconly.dart';
import '../../Favorites_Screen/favorites_screen.dart';
import '../movies_screen.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int categoriesCurrentNumber = 0;

  int bottomNavBarCurrentIndex = 0;

  void changeCategoriesNumber(int index) {
    categoriesCurrentNumber = index;
    emit(ChangeCategoriesCurrentIndexState());
  }

  List<MoviesResult>? nowPlayingModel;

  void getNowPlayingMovies() {
    emit(GetNowPlayingMoviesLoadingState());

    Dio().get(ApiConstance.nowPlayingMoviesPath).then((value) {
      nowPlayingModel = List<MoviesResult>.from(
          value.data['results'].map((e) => MoviesResult.fromJson(e)));
      emit(GetNowPlayingMoviesSuccessState());
    }).catchError((error) {
      GetNowPlayingMoviesErrorState(error.toString());
    });
  }

  List<MoviesResult>? upcomingMovie;

  void getUpcomingMovies() {
    emit(GetUpcomingMoviesLoadingState());

    Dio().get(ApiConstance.upcomingMoviesPath).then((value) {
      (value.data['result']);
      upcomingMovie = List<MoviesResult>.from(
          value.data['results'].map((e) => MoviesResult.fromJson(e)));

      emit(GetUpcomingMoviesSuccessState());
    }).catchError((error) {
      GetUpcomingMoviesErrorState(error.toString());
    });
  }

  List<GenresModel>? genresList;

  void getGenresList() {
    emit(GetGenresListLoadingState());

    Dio().get(ApiConstance.categoriesStringPath).then((value) {
      genresList = List<GenresModel>.from(
          value.data['genres'].map((e) => GenresModel.fromJson(e)));
      emit(GetGenresListSuccessState());
    }).catchError((error) {
      GetGenresListErrorState(error.toString());
    });
  }

  List<MoviesResult>? categoryMovies;

  void getCategoryMovies({required int categoryId}) {
    emit(GetCategoryMoviesLoadingState());

    Dio().get(ApiConstance.moviesGenresApi(categoryId)).then((value) {
      categoryMovies = List<MoviesResult>.from(
          value.data['results'].map((e) => MoviesResult.fromJson(e)));
      emit(GetCategoryMoviesSuccessState());
    }).catchError((error) {
      GetCategoryMoviesErrorState(error.toString());
    });
  }

  List<MoviesResult>? trendingMovies;

  void getTrendingMovies() {
    emit(GetTrendingMoviesLoadingState());

    Dio().get(ApiConstance.trendingMoviesPath).then((value) {(value.data['result']);
      trendingMovies = List<MoviesResult>.from(
          value.data['results'].map((e) => MoviesResult.fromJson(e)));

      emit(GetTrendingMoviesSuccessState());
    }).catchError((error) {
      GetTrendingMoviesErrorState(error.toString());
    });
  }

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.popcorn),
      label: AppStrings.movies,
    ),
    const BottomNavigationBarItem(
        icon: Icon(IconlyBroken.ic_like), label: AppStrings.favorites),
  ];

  List<Widget> homeLayoutScreens = [
    const MainMoviesScreen(),
    const FavoritesScreen(),
  ];

  void changeCurrentIndex(int index) {
    bottomNavBarCurrentIndex = index;
    emit(BottomNavState());
  }

  List<Movie>? favoriteMoviesList = [];
  List<int>? keys = [];

  getBox() async {
    var box = await Hive.openBox<Movie>('movie');
    keys = [];
    keys = box.keys.cast<int>().toList();

    favoriteMoviesList = [];

    for (var key in keys!) {
      favoriteMoviesList?.add(box.get(key)!);
    }
    box.close();
    emit(GetBoxState());
  }

  // Add Item From Db (Hive)
  addToFavorites(Movie movie) async {
    await Hive.openBox<Movie>('movie').then((value) {
      value.add(movie);
      emit(AddToFavoritesSuccessState());
    }).catchError((error) {
      emit(AddToFavoritesErrorState());
    }).then(
      (value) => getBox(),
    );
  }

  // Delete Item From Db (Hive)
  deleteTask(Movie movie) async {
    await Hive.openBox<Movie>('movie').then((value) {
      final Map<dynamic, Movie> movieMap = value.toMap();
      dynamic desiredKey;
      movieMap.forEach((key, value) {
        emit(DeleteMovieFromFavoritesSuccessState());
        if (value.id == movie.id) {
          desiredKey = key;
        }
      });
      return value.delete(desiredKey);
    }).catchError((error) {
      emit(DeleteMovieFromFavoritesErrorState());
    }).then(
      (value) => getBox(),
    );
  }

  // Bool to check if item in list or not
  bool isFavorite(int id) {
    return favoriteMoviesList!.where((item) => item.id == id).isNotEmpty;
  }
}
