import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/movie.dart';
import '../../modules/Movie_Details_Screen/movie_detail_screen.dart';
import '../../modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';
import '../network/remote/api_constance.dart';

Widget movieWidget({
  required BuildContext context,
  required dynamic movie,
  double? height,
  double? width,
}) {
  return Stack(
    children: [
      Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                          id: movie.id!,
                        )));
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: CachedNetworkImage(
              width: 120.0,
              fit: BoxFit.cover,
              imageUrl: movie.backdropPath == null ? ApiConstance.noImagePhoto : ApiConstance.imageUrl(movie.backdropPath!),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[850]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: 170.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Image.network(
                fit: BoxFit.cover,
                  ApiConstance.noImagePhoto),
            ),
          ),
        ),
      ),
      Positioned(
          top: 8.0,
          right: 15.0,
          child: Container(
            padding: const EdgeInsetsDirectional.all(5),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade500.withOpacity(0.5)
            ),
            child: InkWell(
                onTap: () {
                  buildFavoritesButtonFunc(context, movie);
                },
                child: MoviesCubit.get(context).isFavorite(movie.id)
                    ? const Icon(
                        Icons.favorite,
                        size: 24,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        size: 24,
                      )),
          ))
    ],
  );
}

buildFavoritesButtonFunc(context, movie) {
  if (MoviesCubit.get(context).isFavorite(movie.id)) {
    MoviesCubit.get(context).deleteTask(Movie(
        id: movie.id!,
        backdropPath: movie.backdropPath == null ? ApiConstance.noImagePhoto :movie.backdropPath!,
        title: movie.title!,
        isFavorite: false));
  } else {
    MoviesCubit.get(context).addToFavorites(Movie(
        id: movie.id!,
        backdropPath:  movie.backdropPath == null ? ApiConstance.noImagePhoto :movie.backdropPath!,
        title: movie.title!,
        isFavorite: true));
  }
}
