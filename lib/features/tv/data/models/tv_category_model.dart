enum TvCategory { popular, airingToday, topRated, onTheAir }

extension TvCategoryX on TvCategory {
  String get title {
    switch (this) {
      case TvCategory.popular:
        return 'Popular';
      case TvCategory.airingToday:
        return 'Airing Today';
      case TvCategory.topRated:
        return 'Top Rated';
      case TvCategory.onTheAir:
        return 'On The Air';
    }
  }

  String get apiPath {
    switch (this) {
      case TvCategory.popular:
        return 'popular';
      case TvCategory.airingToday:
        return 'airing_today';
      case TvCategory.topRated:
        return 'top_rated';
      case TvCategory.onTheAir:
        return 'on_the_air';
    }
  }
}
