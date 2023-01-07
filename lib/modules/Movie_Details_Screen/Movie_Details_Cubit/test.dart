// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
//
// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//           headerSliverBuilder: ((BuildContext context, innerBoxIsScrolled) => [
//             SliverOverlapAbsorber(
//                 handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                     context),
//                 sliver: SliverAppBar(
//                   centerTitle: false,
//                   title: ,
//                   stretch: true,
//                   leading: IconButton(
//                     icon: const Icon(
//                       Icons.chevron_left,
//                       size: 25,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   pinned: true,
//                   expandedHeight: 250.0,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: FadeIn(
//                       duration: const Duration(milliseconds: 500),
//                       child: ShaderMask(
//                         shaderCallback: (rect) {
//                           return const LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black,
//                               Colors.black,
//                               Colors.transparent,
//                             ],
//                             stops: [0.0, 0.5, 1.0, 1.0],
//                           ).createShader(
//                             Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
//                           );
//                         },
//                         blendMode: BlendMode.dstIn,
//                         child: CachedNetworkImage(
//                           width: MediaQuery
//                               .of(context)
//                               .size
//                               .width,
//                           imageUrl: ApiConstance.imageUrl(movie!.backdropPath!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   floating: true,
//                   snap: true,
//                 )),
//           ]),
//           body: ListView(
//             padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
//             children: [
//               FadeInUp(
//                 from: 20,
//                 duration: const Duration(milliseconds: 500),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(movie.title!,
//                           style: GoogleFonts.poppins(
//                             fontSize: 23,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.2,
//                           )),
//                       const SizedBox(height: 8.0),
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 2.0,
//                               horizontal: 8.0,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[800],
//                               borderRadius: BorderRadius.circular(4.0),
//                             ),
//                             child: Text(
//                               movie.releaseDate!.split('-')[0],
//                               style: const TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 16.0),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: 20.0,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Text(
//                                 (movie.voteAverage! / 2).toStringAsFixed(1),
//                                 style: const TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 1.2,
//                                 ),
//                               ),
//                               const SizedBox(width: 4.0),
//                               Text(
//                                 '(${movie.voteAverage})',
//                                 style: const TextStyle(
//                                   fontSize: 1.0,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 1.2,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(width: 16.0),
//                           Text(
//                             _showDuration(movie.runtime!),
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20.0),
//                       Text(
//                         movie.overview!,
//                         style: const TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         'Genres: ${_showGenres(movie.genres!)}',
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               FadeInUp(
//                 from: 20,
//                 duration: const Duration(milliseconds: 500),
//                 child: Text(
//                   'More like this'.toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
