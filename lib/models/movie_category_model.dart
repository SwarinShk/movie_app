enum MovieCategory { popular, nowPlaying, topRated, upcoming }

extension MovieCategoryX on MovieCategory {
  String get title {
    switch (this) {
      case MovieCategory.popular:
        return 'Popular';
      case MovieCategory.nowPlaying:
        return 'Now Playing';
      case MovieCategory.topRated:
        return 'Top Rated';
      case MovieCategory.upcoming:
        return 'Upcoming';
    }
  }

  String get apiPath {
    switch (this) {
      case MovieCategory.popular:
        return 'popular';
      case MovieCategory.nowPlaying:
        return 'now_playing';
      case MovieCategory.topRated:
        return 'top_rated';
      case MovieCategory.upcoming:
        return 'upcoming';
    }
  }
}
