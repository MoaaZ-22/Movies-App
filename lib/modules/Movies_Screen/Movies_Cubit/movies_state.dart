part of 'movies_cubit.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class ChangeCategoriesCurrentIndexState extends MoviesState {}

class GetNowPlayingMoviesLoadingState extends MoviesState {}

class GetNowPlayingMoviesSuccessState extends MoviesState {}

class GetNowPlayingMoviesErrorState extends MoviesState {
  final String error;

  GetNowPlayingMoviesErrorState(this.error);
}

class GetUpcomingMoviesLoadingState extends MoviesState {}

class GetUpcomingMoviesSuccessState extends MoviesState {}

class GetUpcomingMoviesErrorState extends MoviesState {
  final String error;

  GetUpcomingMoviesErrorState(this.error);
}

class GetGenresListLoadingState extends MoviesState {}

class GetGenresListSuccessState extends MoviesState {}

class GetGenresListErrorState extends MoviesState {
  final String error;

  GetGenresListErrorState(this.error);
}

class GetCategoryMoviesLoadingState extends MoviesState {}

class GetCategoryMoviesSuccessState extends MoviesState {}

class GetCategoryMoviesErrorState extends MoviesState {
  final String error;

  GetCategoryMoviesErrorState(this.error);
}

class BottomNavState extends MoviesState {}

class GetBoxState extends MoviesState {}

class AddToFavoritesSuccessState extends MoviesState {}

class AddToFavoritesErrorState extends MoviesState {}

class DeleteMovieFromFavoritesSuccessState extends MoviesState {}

class DeleteMovieFromFavoritesErrorState extends MoviesState {}


class GetTrendingMoviesLoadingState extends MoviesState {}

class GetTrendingMoviesSuccessState extends MoviesState {}

class GetTrendingMoviesErrorState extends MoviesState {
  final String error;

  GetTrendingMoviesErrorState(this.error);
}
