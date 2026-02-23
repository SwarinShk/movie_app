import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';
import 'package:movie_app/features/watchlist/data/services/watchlist_service.dart';

class WatchlistProvider extends ChangeNotifier {
  final WatchlistService _service;
  final AuthServiceProvider _auth;

  WatchlistProvider({
    required AuthServiceProvider auth,
    WatchlistService? service,
  }) : _auth = auth,
       _service = service ?? WatchlistService();

  PaginatedMovieModel? movieWatchlist;
  TvModel? tvWatchlist;

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
  bool isMovieInWatchlist(int id) => _movieStatus[id] ?? false;
  bool isTvInWatchlist(int id) => _tvStatus[id] ?? false;

  /// Fetch both watchlists
  Future<void> fetchAll({bool reset = false}) async {
    if (reset) {
      _moviePage = 1;
      _tvPage = 1;
      _hasMoreMovies = true;
      _hasMoreTv = true;
      movieWatchlist?.results.clear();
      tvWatchlist?.results.clear();
    }

    await Future.wait([
      fetchMovieWatchlist(initialLoad: true),
      fetchTvWatchlist(initialLoad: true),
    ]);
  }

  /// Toggle watchlist (optimistic)
  Future<void> toggleWatchlist({
    required int mediaId,
    required String mediaType,
    required bool isInWatchlist,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) {
      Fluttertoast.showToast(
        msg: "You must be logged in.",
        backgroundColor: AppColor.redAccent,
      );
      return;
    }

    if (isItemLoading(mediaId)) return;

    final newState = !isInWatchlist;
    _setItemState(mediaId, newState, mediaType);
    _itemLoading[mediaId] = true;
    notifyListeners();

    try {
      await _service.addToWatchlist(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        mediaId: mediaId,
        mediaType: mediaType,
        addToWatchlist: newState,
      );
      Fluttertoast.showToast(
        msg: newState ? "Added to watchlist" : "Removed from watchlist",
        backgroundColor: AppColor.green,
      );
    } catch (e) {
      _setItemState(mediaId, isInWatchlist, mediaType);
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
  Future<void> fetchMovieWatchlist({
    bool initialLoad = false,
    bool reset = false,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) return;

    if (reset) {
      _moviePage = 1;
      _hasMoreMovies = true;
      movieWatchlist?.results.clear();
    }

    if (!_hasMoreMovies) return;

    initialLoad ? isLoading = true : isFetchingMoreMovies = true;
    notifyListeners();

    try {
      final res = await _service.fetchMovieWatchlist(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        page: _moviePage,
      );

      if (_moviePage == 1 || movieWatchlist == null) {
        movieWatchlist = res;
      } else {
        movieWatchlist!.results.addAll(res.results);
      }

      // Rebuild watchlist status map
      _movieStatus.clear();
      for (var movie in movieWatchlist!.results) {
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
  Future<void> fetchTvWatchlist({
    bool initialLoad = false,
    bool reset = false,
  }) async {
    if (_auth.account == null || _auth.sessionId == null) return;

    if (reset) {
      _tvPage = 1;
      _hasMoreTv = true;
      tvWatchlist?.results.clear();
    }

    if (!_hasMoreTv) return;

    initialLoad ? isLoading = true : isFetchingMoreTv = true;
    notifyListeners();

    try {
      final res = await _service.fetchTvWatchlist(
        accountId: _auth.account!.id,
        sessionId: _auth.sessionId!,
        page: _tvPage,
      );

      if (_tvPage == 1 || tvWatchlist == null) {
        tvWatchlist = res;
      } else {
        tvWatchlist!.results.addAll(res.results);
      }

      // Rebuild watchlist status map
      _tvStatus.clear();
      for (var tv in tvWatchlist!.results) {
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
    movieWatchlist = null;
    tvWatchlist = null;
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
