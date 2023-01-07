class MoviesResult {
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  MoviesResult(
      {this.backdropPath,
      this.genreIds,
      this.id,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.voteCount
      });

  MoviesResult.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'] ?? json['name'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }
}
