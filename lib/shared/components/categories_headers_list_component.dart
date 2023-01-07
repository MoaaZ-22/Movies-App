import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';

class CategoriesHeaderList extends StatelessWidget {
  const CategoriesHeaderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var genresList = MoviesCubit.get(context).genresList;
        return ConditionalBuilder(
          condition: MoviesCubit.get(context).genresList != null,
          builder: (context) => FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 45.0,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: genresList!.length,
                itemBuilder: (context, index) {
                  final genres = genresList[index];
                  return Container(
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        color:
                            MoviesCubit.get(context).categoriesCurrentNumber ==
                                    index
                                ? Colors.orange
                                : Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        MoviesCubit.get(context).changeCategoriesNumber(index);

                        MoviesCubit.get(context).getCategoryMovies(categoryId:genresList[index].id!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          genres.name!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: MoviesCubit.get(context)
                                        .categoriesCurrentNumber ==
                                    index
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
              ),
            ),
          ),
          fallback: (context) => const SizedBox(
              height: 45, child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
