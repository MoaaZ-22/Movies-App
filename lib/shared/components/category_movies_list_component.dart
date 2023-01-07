import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';
import '../widgets/movie_widget.dart';

class CategoryMoviesListComponent extends StatelessWidget {
  const CategoryMoviesListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoryMovies = MoviesCubit.get(context).categoryMovies;
        return ConditionalBuilder(
          condition: MoviesCubit.get(context).categoryMovies != null &&
              state is! GetCategoryMoviesLoadingState,
          builder: (context) => FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 170.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: categoryMovies!.length,
                itemBuilder: (context, index) {
                  final movie = categoryMovies[index];
                  return movieWidget(context: context, movie: movie, height: 170);
                },
              ),
            ),
          ),
          fallback: (context) => const SizedBox(
              height: 170, child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
