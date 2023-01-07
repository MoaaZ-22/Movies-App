import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/movie_details_model.dart';
import 'package:movies/shared/network/remote/api_constance.dart';

import '../../../models/movie_cast_model.dart';
part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  MovieDetailsModel? movieDetails;
  void getMovieDetails(int id)
  {
    emit(GetMovieDetailsLoadingState());
    Dio().get(ApiConstance.movieDetailsPath(id)).then((value)
    {
      movieDetails = MovieDetailsModel.fromJson(value.data);
      emit(GetMovieDetailsSuccessState());
    }).catchError((error)
    {
      emit(GetMovieDetailsErrorState());
    }
    );
  }

  List<Cast>? movieCast;
  void getMovieCast(int id)
  {

    emit(GetMovieDetailsLoadingState());
    Dio().get(ApiConstance.movieCastPath(id)).then((value)
    {
      movieCast = List<Cast>.from(value.data['cast'].map((e) => Cast.fromJson(e)));
      emit(GetMovieDetailsSuccessState());
    });
  }
}
