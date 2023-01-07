import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/modules/Movies_Screen/Movies_Cubit/movies_cubit.dart';
import 'package:movies/modules/Trending_Screen/trending_screen.dart';
import 'package:movies/shared/styles/app_colors.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          return Scaffold(
            body: cubit.homeLayoutScreens[cubit.bottomNavBarCurrentIndex],
            bottomNavigationBar: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                iconSize: 25,
                landscapeLayout:
                BottomNavigationBarLandscapeLayout.spread,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: const TextStyle(color: Colors.grey, height: 1.4),
                selectedItemColor: Colors.white,
                selectedLabelStyle: const TextStyle(color: Colors.white,height: 1.4),
                elevation: 0.0,
                backgroundColor: AppColors.defaultColor,
                items: cubit.bottomNavBarItems,
                currentIndex: cubit.bottomNavBarCurrentIndex,
                onTap: (index) {
                  cubit.changeCurrentIndex(index);
                },
              ),
            ),
            floatingActionButton: MaterialButton(
              elevation: 10,
              color: Colors.grey.shade800,
              height: 80,
              shape: const CircleBorder(),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TrendingScreen()));
              },
              child:  SvgPicture.asset('assets/images/fire-svgrepo-com.svg', height: 50, width: 50,)
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      );
  }
}
