class MovieDetailsModel {
  String? backdropPath;
  List<Genres>? genres;
  int? id;
  String? overview;
  String? releaseDate;
  int? runtime;
  String? title;
  double? voteAverage;
  int? voteCount;

  MovieDetailsModel(
      {
      this.backdropPath,
      this.genres,
      this.id,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.title,
      this.voteAverage,
      this.voteCount});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    id = json['id'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['runtime'] = runtime;
    data['title'] = title;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
