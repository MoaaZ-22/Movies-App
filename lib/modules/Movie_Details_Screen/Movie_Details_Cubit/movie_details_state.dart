part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {

}

class MovieDetailsInitial extends MovieDetailsState {}

class GetMovieDetailsLoadingState extends MovieDetailsState {}
class GetMovieDetailsSuccessState extends MovieDetailsState {}
class GetMovieDetailsErrorState extends MovieDetailsState {}
