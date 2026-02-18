class SearchModel {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<SearchResult> results;

  const SearchModel({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => SearchResult.fromJson(e))
          .toList(),
    );
  }

  /// Used for pagination (infinite scroll)
  SearchModel copyWith({
    int? page,
    int? totalPages,
    int? totalResults,
    List<SearchResult>? results,
  }) {
    return SearchModel(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  /// Merge next page data
  SearchModel merge(SearchModel newData) {
    return copyWith(
      page: newData.page,
      totalPages: newData.totalPages,
      totalResults: newData.totalResults,
      results: [...results, ...newData.results],
    );
  }
}

// ==============================
// MEDIA TYPE
// ==============================

enum MediaType { movie, tv, person, unknown }

extension MediaTypeX on MediaType {
  bool get isMovie => this == MediaType.movie;
  bool get isTv => this == MediaType.tv;
  bool get isPerson => this == MediaType.person;
}

// ==============================
// SEARCH RESULT
// ==============================

class SearchResult {
  final int id;
  final MediaType mediaType;
  final bool adult;

  /// Movie / TV
  final String? title;
  final String? originalTitle;

  /// TV / Person
  final String? name;
  final String? originalName;

  final String? overview;

  /// Images
  final String? posterPath;
  final String? backdropPath;
  final String? profilePath;

  /// Dates
  final String? releaseDate; // movie
  final String? firstAirDate; // tv

  final double? voteAverage;
  final int? voteCount;
  final double? popularity;

  /// Person-specific
  final String? knownForDepartment;

  const SearchResult({
    required this.id,
    required this.mediaType,
    required this.adult,
    this.title,
    this.originalTitle,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.profilePath,
    this.releaseDate,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.popularity,
    this.knownForDepartment,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      mediaType: _parseMediaType(json['media_type']),
      adult: json['adult'],

      title: json['title'],
      originalTitle: json['original_title'],

      name: json['name'],
      originalName: json['original_name'],

      overview: json['overview'],

      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      profilePath: json['profile_path'],

      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],

      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
      popularity: (json['popularity'] as num?)?.toDouble(),

      knownForDepartment: json['known_for_department'],
    );
  }

  static MediaType _parseMediaType(String? type) {
    switch (type) {
      case 'movie':
        return MediaType.movie;
      case 'tv':
        return MediaType.tv;
      case 'person':
        return MediaType.person;
      default:
        return MediaType.unknown;
    }
  }

  // =====================================
  // 🔥 Unified Helpers for UI
  // =====================================

  /// Display title for movie / tv / person
  String get displayTitle => title ?? name ?? '';

  /// Display original title
  String get displayOriginalTitle => originalTitle ?? originalName ?? '';

  /// Display release / air date
  String get displayDate => releaseDate ?? firstAirDate ?? '';

  /// Image priority logic
  String? get displayImage {
    if (mediaType.isPerson) return profilePath;
    return posterPath ?? backdropPath;
  }

  bool get hasImage => displayImage != null && displayImage!.isNotEmpty;

  bool get isMovie => mediaType.isMovie;
  bool get isTv => mediaType.isTv;
  bool get isPerson => mediaType.isPerson;
}
