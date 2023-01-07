import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/shared/components/now_playing_component.dart';
import 'package:movies/shared/components/upcoming_movies_component.dart';
import '../../shared/components/categories_headers_list_component.dart';
import '../../shared/components/category_movies_list_component.dart';
import '../../shared/styles/app_strings.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: const Key('movieScrollView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NowPlayingComponent(),
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 8.0),
              child: Text(
                AppStrings.upcoming,
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
              ),
            ),
            const UpcomingMoviesComponent(),
            Container(
              margin: const EdgeInsets.fromLTRB(
                16.0,
                24.0,
                16.0,
                8.0,
              ),
              child: Text(
                AppStrings.movies,
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
              ),
            ),
            const CategoriesHeaderList(),
            const SizedBox(height: 20.0),
            const CategoryMoviesListComponent(),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
