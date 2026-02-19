import 'package:intl/intl.dart';

class TvModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  TvModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// Merge another TvModel into this one, avoiding duplicates by `id`
  TvModel merge(TvModel other) {
    if (other.page <= page) return this;

    final existingIds = results.map((e) => e.id).toSet();

    final newResults = other.results
        .where((result) => !existingIds.contains(result.id))
        .toList();

    return TvModel(
      page: other.page,
      results: [...results, ...newResults],
      totalPages: other.totalPages,
      totalResults: other.totalResults,
    );
  }

  TvModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) => TvModel(
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
    page: json["page"] ?? 1,
    results: json["results"] != null
        ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
        : [],
    totalPages: json["total_pages"] ?? 1,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  final bool adult;
  final String? backdropPath;
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    this.backdropPath,
    this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    bool? adult,
    String? backdropPath,
    DateTime? firstAirDate,
    List<int>? genreIds,
    int? id,
    String? name,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
  }) => Result(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    firstAirDate: firstAirDate ?? this.firstAirDate,
    genreIds: genreIds ?? this.genreIds,
    id: id ?? this.id,
    name: name ?? this.name,
    originCountry: originCountry ?? this.originCountry,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    originalName: originalName ?? this.originalName,
    overview: overview ?? this.overview,
    popularity: popularity ?? this.popularity,
    posterPath: posterPath ?? this.posterPath,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    firstAirDate:
        (json["first_air_date"] != null &&
            json["first_air_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["first_air_date"])
        : null,
    genreIds: json["genre_ids"] != null
        ? List<int>.from(json["genre_ids"].map((x) => x))
        : [],
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    originCountry: json["origin_country"] != null
        ? List<String>.from(json["origin_country"].map((x) => x))
        : [],
    originalLanguage: json["original_language"] ?? '',
    originalName: json["original_name"] ?? '',
    overview: json["overview"] ?? '',
    popularity: (json["popularity"]?.toDouble() ?? 0.0),
    posterPath: json["poster_path"] ?? '',
    voteAverage: (json["vote_average"]?.toDouble() ?? 0.0),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate != null
        ? DateFormat('yyyy-MM-dd').format(firstAirDate!)
        : null,
    "genre_ids": genreIds,
    "id": id,
    "name": name,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
