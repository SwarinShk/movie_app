class PaginatedMovieModel {
  final Dates? dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  PaginatedMovieModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedMovieModel.fromJson(Map<String, dynamic> json) {
    return PaginatedMovieModel(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => Movie.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Dates {
  final String? maximum;
  final String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(maximum: json['maximum'], minimum: json['minimum']);
  }

  Map<String, dynamic> toJson() {
    return {'maximum': maximum, 'minimum': minimum};
  }
}

class Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
