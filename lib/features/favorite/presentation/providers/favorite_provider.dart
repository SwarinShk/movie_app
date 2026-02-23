import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/favorite/data/services/favorite_service.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService _service;
  final AuthServiceProvider _auth;

  FavoriteProvider({
    required AuthServiceProvider auth,
    FavoriteService? service,
  }) : _auth = auth,
       _service = service ?? FavoriteService();

  PaginatedMovieModel? movieFavorite;
  TvModel? tvFavorite;

  bool isLoading = false;
  bool isFetchingMoreMovies = false;
  bool isFetchingMoreTv = false;
  String? error;

  final Map<int, bool> _itemLoading = {};
  final Map<int, bool> _movieStatus = {};
  final Map<int, bool> _tvStatus = {};

  int _moviePage = 1;
  int _tvPage = 1;
  bool _hasMoreMovies = true;
  bool _hasMoreTv = true;

  bool isItemLoading(int id) => _itemLoading[id] ?? false;
  bool isMovieInFavorite(int id) => _movieStatus[id] ?? false;
  bool isTvInFavorite(int id) => _tvStatus[id] ?? false;

  /// Fetch both watchlists
  Future<void> fetchAll({bool reset = false}) async {
    if (reset) {
      _moviePage = 1;
      _tvPage = 1;
      _hasMoreMovies = true;
      _hasMoreTv = true;
      movieFavorite?.results.clear();
      tvFavorite?.results.clear();
    }

    await Future.wait([
      fetchMovieFavorite(initialLoad: true),
      fetchTvFavorite(initialLoad: true),
    ]);
  }

  /// Toggle watchlist (optimistic)
  Future<void> toggleFavorite({
    required int mediaId,
    required String mediaType,
    required bool isInFavorite,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) {
      Fluttertoast.showToast(
        msg: "You must be logged in.",
        backgroundColor: AppColor.redAccent,
      );
      return;
    }

    if (isItemLoading(mediaId)) return;

    final newState = !isInFavorite;
    _setItemState(mediaId, newState, mediaType);
    _itemLoading[mediaId] = true;
    notifyListeners();

    try {
      await _service.addToFavorite(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        mediaId: mediaId,
        mediaType: mediaType,
        addToFavorite: newState,
      );
      Fluttertoast.showToast(
        msg: newState ? "Added to favorite" : "Removed from favorite",
        backgroundColor: AppColor.green,
      );
    } catch (e) {
      _setItemState(mediaId, isInFavorite, mediaType);
      Fluttertoast.showToast(
        msg: "Update failed. Check connection.",
        backgroundColor: AppColor.redAccent,
      );
    } finally {
      _itemLoading[mediaId] = false;
      notifyListeners();
    }
  }

  /// Fetch movie watchlist with pagination
  Future<void> fetchMovieFavorite({
    bool initialLoad = false,
    bool reset = false,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) return;

    if (reset) {
      _moviePage = 1;
      _hasMoreMovies = true;
      movieFavorite?.results.clear();
    }

    if (!_hasMoreMovies) return;

    initialLoad ? isLoading = true : isFetchingMoreMovies = true;
    notifyListeners();

    try {
      final res = await _service.fetchMovieFavorite(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        page: _moviePage,
      );

      if (_moviePage == 1 || movieFavorite == null) {
        movieFavorite = res;
      } else {
        movieFavorite!.results.addAll(res.results);
      }

      // Rebuild watchlist status map
      _movieStatus.clear();
      for (var movie in movieFavorite!.results) {
        _movieStatus[movie.id] = true;
      }

      _hasMoreMovies = _moviePage < res.totalPages;
      if (_hasMoreMovies) _moviePage++;
    } catch (e) {
      error = e.toString();
    } finally {
      initialLoad ? isLoading = false : isFetchingMoreMovies = false;
      notifyListeners();
    }
  }

  /// Fetch TV watchlist with pagination
  Future<void> fetchTvFavorite({
    bool initialLoad = false,
    bool reset = false,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) return;

    if (reset) {
      _tvPage = 1;
      _hasMoreTv = true;
      tvFavorite?.results.clear();
    }

    if (!_hasMoreTv) return;

    initialLoad ? isLoading = true : isFetchingMoreTv = true;
    notifyListeners();

    try {
      final res = await _service.fetchTvFavorite(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        page: _tvPage,
      );

      if (_tvPage == 1 || tvFavorite == null) {
        tvFavorite = res;
      } else {
        tvFavorite!.results.addAll(res.results);
      }

      // Rebuild watchlist status map
      _tvStatus.clear();
      for (var tv in tvFavorite!.results) {
        _tvStatus[tv.id] = true;
      }

      _hasMoreTv = _tvPage < res.totalPages;
      if (_hasMoreTv) _tvPage++;
    } finally {
      initialLoad ? isLoading = false : isFetchingMoreTv = false;
      notifyListeners();
    }
  }

  /// Optimistic UI helper
  void _setItemState(int id, bool value, String mediaType) {
    if (mediaType == 'movie') {
      _movieStatus[id] = value;
    } else if (mediaType == 'tv') {
      _tvStatus[id] = value;
    }
  }

  /// Clear all data
  void clear() {
    movieFavorite = null;
    tvFavorite = null;
    _movieStatus.clear();
    _tvStatus.clear();
    _itemLoading.clear();
    error = null;
    _moviePage = 1;
    _tvPage = 1;
    _hasMoreMovies = true;
    _hasMoreTv = true;
    isLoading = false;
    isFetchingMoreMovies = false;
    isFetchingMoreTv = false;
    notifyListeners();
  }
}
