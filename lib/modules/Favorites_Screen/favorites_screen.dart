import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';
import 'package:movies/shared/styles/app_colors.dart';
import 'package:movies/shared/styles/app_strings.dart';
import '../../shared/widgets/movie_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.defaultColor,
            centerTitle: true,
            title: Text(AppStrings.favorites, style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),),
          ),
          body: buildBodyWidget(context),
        );
      },
    );
  }
}

Widget buildBodyWidget(context)
{
  if(MoviesCubit.get(context).favoriteMoviesList!.isEmpty)
    {
     return Center(child: Text('Empty ...', style: GoogleFonts.poppins(
       fontSize: 16,
       fontWeight: FontWeight.w500,
       color: AppColors.orangeColor,
       letterSpacing: 0.15,
     ),),);
    }
  else
    {
      var movieList = MoviesCubit.get(context).favoriteMoviesList;
      return FadeInUp(
        duration: const Duration(milliseconds: 350),
        child: GridView.builder(
          padding: const EdgeInsetsDirectional.only(
              top: 20, bottom: 20, start: 16, end: 16),
          itemCount: movieList!.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return movieWidget(context: context, movie: movieList[index], height: double.infinity, width: double.infinity);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            mainAxisExtent: 215.0,
            childAspectRatio: 0.7,
            crossAxisCount: 2,
          ),
        ),
      );
    }
}