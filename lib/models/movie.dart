import 'package:hive_flutter/adapters.dart';
part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie
{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String backdropPath;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final bool isFavorite;

  Movie({required this.id, required this.backdropPath, required this.title, required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'backdropPath': backdropPath,
      'title': title,
      'isFavorite': isFavorite,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      backdropPath: json['backdropPath'] ?? '',
      title: json['title'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}