import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/layout/home_layout_screen.dart';
import 'package:movies/modules/Movie_Details_Screen/Movie_Details_Cubit/movie_details_cubit.dart';
import 'package:movies/shared/styles/app_colors.dart';
import 'package:movies/shared/styles/app_strings.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/movie_details_model.dart';
import '../../shared/network/remote/api_constance.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsCubit()..getMovieDetails(id)..getMovieCast(id),
      child: const Scaffold(
        body: MovieDetailContent(
        ),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {

  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
      listener: (context, state) {
        if(state is GetMovieDetailsErrorState)
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar
            (
              backgroundColor: AppColors.orangeColor,
              elevation: 5,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 4),
              content: Text('The movie has no details',
                textAlign: TextAlign.center,)));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeLayoutScreen()),
          );
        }
      },
      builder: (context, state) {
        final movie = MovieDetailsCubit
            .get(context)
            .movieDetails;
        return ConditionalBuilder(
          condition: MovieDetailsCubit.get(context).movieDetails != null && MovieDetailsCubit.get(context).movieCast != null,
          builder: (context) => NestedScrollView(
              headerSliverBuilder: ((BuildContext context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      centerTitle: false,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      pinned: true,
                      expandedHeight: 300.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0.0, 0.5, 1.0, 1.0],
                              ).createShader(
                                Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              imageUrl: movie.backdropPath == null ? ApiConstance.noImagePhoto : ApiConstance.imageUrl(movie.backdropPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      floating: true,
                      snap: true,
                    )),
              ]),
              body: ListView(
                padding: const EdgeInsetsDirectional.only(top: 80),
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie!.title!,
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              )),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  movie.releaseDate!.split('-')[0],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    (movie.voteAverage! / 2).toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '(${movie.voteAverage})',
                                    style: const TextStyle(
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _showDuration(movie.runtime!),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            movie.overview!,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${AppStrings.genres}: ${_showGenres(movie.genres!)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 00.0),
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        AppStrings.movieCast.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                    child: _showCast(),
                  )
                ],
              )),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

Widget _showCast() {
  return BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return FadeInUp(
      duration: const Duration(milliseconds: 350),
      child: GridView.builder(
        itemCount: MovieDetailsCubit.get(context).movieCast?.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index)
        {
          final castList = MovieDetailsCubit.get(context).movieCast![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(10.0)),
                child: CachedNetworkImage(
                  imageUrl: castList.profilePath == null ? ApiConstance.noImagePhoto : ApiConstance.imageUrl(castList.profilePath!),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 170.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                castList.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            ],
          );
        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 9.0,
        crossAxisSpacing: 3.0,
        mainAxisExtent: 215.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
      ),
    );
  },
);
}
}
