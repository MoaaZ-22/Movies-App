import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';
import 'package:movies/shared/styles/app_colors.dart';
import 'package:movies/shared/styles/app_strings.dart';
import '../../shared/widgets/movie_widget.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

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
            title: Text(AppStrings.trending, style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),),
          ),
          body: buildBodyWidget(context,state),
        );
      },
    );
  }
}

Widget buildBodyWidget(context, state)
{
  if(state is GetTrendingMoviesErrorState)
  {
    return Center(child: Text(state.error.toString().toUpperCase(), style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.orangeColor,
      letterSpacing: 0.15,
    ),),);
  }
  else
  {
    var movieList = MoviesCubit.get(context).trendingMovies;
    return ConditionalBuilder(
      condition: state is !GetTrendingMoviesSuccessState,
      builder: (context) => FadeInUp(
        duration: const Duration(milliseconds: 350),
        child: ListView.separated(
          padding: const EdgeInsetsDirectional.only(
              top: 20, bottom: 20, start: 16, end: 16),
          itemCount: movieList!.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return movieWidget(context: context, movie: movieList[index], height: 207, width: double.infinity);
          },
            separatorBuilder: (context, _) => const SizedBox(height: 8,),

        ),
      ),
      fallback: (context)  => const Center(child: CircularProgressIndicator(color: AppColors.orangeColor,),),
    );
  }
}