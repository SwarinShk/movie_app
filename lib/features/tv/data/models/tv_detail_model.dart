class TvDetail {
  final bool adult;
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime? lastAirDate;
  final TEpisodeToAir? lastEpisodeToAir;
  final String name;
  final TEpisodeToAir? nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<Network> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetail.fromJson(Map<String, dynamic> json) {
    return TvDetail(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"],
      createdBy:
          (json["created_by"] as List?)
              ?.map((e) => CreatedBy.fromJson(e))
              .toList() ??
          [],
      episodeRunTime:
          (json["episode_run_time"] as List?)?.map((e) => e as int).toList() ??
          [],
      firstAirDate: json["first_air_date"] != null
          ? DateTime.tryParse(json["first_air_date"])
          : null,
      genres:
          (json["genres"] as List?)?.map((e) => Genre.fromJson(e)).toList() ??
          [],
      homepage: json["homepage"],
      id: json["id"] ?? 0,
      inProduction: json["in_production"] ?? false,
      languages:
          (json["languages"] as List?)?.map((e) => e.toString()).toList() ?? [],
      lastAirDate: json["last_air_date"] != null
          ? DateTime.tryParse(json["last_air_date"])
          : null,
      lastEpisodeToAir: json["last_episode_to_air"] != null
          ? TEpisodeToAir.fromJson(json["last_episode_to_air"])
          : null,
      name: json["name"] ?? '',
      nextEpisodeToAir: json["next_episode_to_air"] != null
          ? TEpisodeToAir.fromJson(json["next_episode_to_air"])
          : null,
      networks:
          (json["networks"] as List?)
              ?.map((e) => Network.fromJson(e))
              .toList() ??
          [],
      numberOfEpisodes: json["number_of_episodes"] ?? 0,
      numberOfSeasons: json["number_of_seasons"] ?? 0,
      originCountry:
          (json["origin_country"] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      originalLanguage: json["original_language"] ?? '',
      originalName: json["original_name"] ?? '',
      overview: json["overview"] ?? '',
      popularity: (json["popularity"] ?? 0).toDouble(),
      posterPath: json["poster_path"],
      productionCompanies:
          (json["production_companies"] as List?)
              ?.map((e) => Network.fromJson(e))
              .toList() ??
          [],
      productionCountries:
          (json["production_countries"] as List?)
              ?.map((e) => ProductionCountry.fromJson(e))
              .toList() ??
          [],
      seasons:
          (json["seasons"] as List?)?.map((e) => Season.fromJson(e)).toList() ??
          [],
      spokenLanguages:
          (json["spoken_languages"] as List?)
              ?.map((e) => SpokenLanguage.fromJson(e))
              .toList() ??
          [],
      status: json["status"] ?? '',
      tagline: json["tagline"],
      type: json["type"] ?? '',
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by": createdBy.map((e) => e.toJson()).toList(),
    "episode_run_time": episodeRunTime,
    "first_air_date": firstAirDate?.toIso8601String(),
    "genres": genres.map((e) => e.toJson()).toList(),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": languages,
    "last_air_date": lastAirDate?.toIso8601String(),
    "last_episode_to_air": lastEpisodeToAir?.toJson(),
    "name": name,
    "next_episode_to_air": nextEpisodeToAir?.toJson(),
    "networks": networks.map((e) => e.toJson()).toList(),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": productionCompanies.map((e) => e.toJson()).toList(),
    "production_countries": productionCountries.map((e) => e.toJson()).toList(),
    "seasons": seasons.map((e) => e.toJson()).toList(),
    "spoken_languages": spokenLanguages.map((e) => e.toJson()).toList(),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class CreatedBy {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"] ?? 0,
    creditId: json["credit_id"] ?? '',
    name: json["name"] ?? '',
    originalName: json["original_name"] ?? '',
    gender: json["gender"] ?? 0,
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "credit_id": creditId,
    "name": name,
    "original_name": originalName,
    "gender": gender,
    "profile_path": profilePath,
  };
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"] ?? 0, name: json["name"] ?? '');

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class TEpisodeToAir {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final DateTime? airDate;
  final int episodeNumber;
  final String? episodeType;
  final String? productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  TEpisodeToAir({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    overview: json["overview"] ?? '',
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
    airDate: json["air_date"] != null
        ? DateTime.tryParse(json["air_date"])
        : null,
    episodeNumber: json["episode_number"] ?? 0,
    episodeType: json["episode_type"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"] ?? 0,
    showId: json["show_id"] ?? 0,
    stillPath: json["still_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "air_date": airDate?.toIso8601String(),
    "episode_number": episodeNumber,
    "episode_type": episodeType,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
  };
}

class Network {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"] ?? 0,
    logoPath: json["logo_path"],
    name: json["name"] ?? '',
    originCountry: json["origin_country"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
}

class Season {
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    airDate: json["air_date"] != null
        ? DateTime.tryParse(json["air_date"])
        : null,
    episodeCount: json["episode_count"] ?? 0,
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    overview: json["overview"] ?? '',
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"] ?? 0,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate?.toIso8601String(),
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"] ?? '',
    iso6391: json["iso_639_1"] ?? '',
    name: json["name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
