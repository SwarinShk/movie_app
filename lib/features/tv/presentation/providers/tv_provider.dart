import 'package:flutter/material.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';
import 'package:movie_app/features/tv/data/services/tv_service.dart';

class TvProvider extends ChangeNotifier {
  final TvService service = TvService();

  final Map<TvCategory, TvModel?> _tv = {
    TvCategory.airingToday: null,
    TvCategory.onTheAir: null,
    TvCategory.popular: null,
    TvCategory.topRated: null,
  };

  final Map<TvCategory, bool> _isLoading = {
    TvCategory.airingToday: false,
    TvCategory.onTheAir: false,
    TvCategory.popular: false,
    TvCategory.topRated: false,
  };

  final Map<TvCategory, bool> _isFetchingMore = {
    TvCategory.airingToday: false,
    TvCategory.onTheAir: false,
    TvCategory.popular: false,
    TvCategory.topRated: false,
  };

  final Map<TvCategory, String?> _error = {
    TvCategory.airingToday: null,
    TvCategory.onTheAir: null,
    TvCategory.popular: null,
    TvCategory.topRated: null,
  };

  TvModel? tvs(TvCategory category) => _tv[category];

  bool isLoading(TvCategory category) => _isLoading[category] ?? false;

  bool isFetchingMore(TvCategory category) =>
      _isFetchingMore[category] ?? false;

  String? error(TvCategory category) => _error[category];

  bool hasMorePages(TvCategory category) {
    final data = _tv[category];
    if (data == null) return false;
    return data.page < data.totalPages;
  }

  Future<void> fetchTv(TvCategory category) async {
    _isLoading[category] = true;
    _error[category] = null;
    notifyListeners();

    try {
      final response = await service.getTv(
        'tv/${category.apiPath}',
        queryParameters: {'page': '1'},
      );

      _tv[category] = response;
    } catch (e) {
      _error[category] = e.toString();
      _tv[category] = null;
    } finally {
      _isLoading[category] = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage(TvCategory category) async {
    if (_isFetchingMore[category] == true ||
        _isLoading[category] == true ||
        !hasMorePages(category)) {
      return;
    }

    _isFetchingMore[category] = true;
    notifyListeners();

    try {
      final currentData = _tv[category];
      if (currentData == null) return;

      final nextPage = currentData.page + 1;

      final response = await service.getTv(
        'tv/${category.apiPath}',
        queryParameters: {'page': nextPage.toString()},
      );

      _tv[category] = currentData.merge(response);
    } catch (e) {
      _error[category] = e.toString();
    } finally {
      _isFetchingMore[category] = false;
      notifyListeners();
    }
  }

  void clearCategory(TvCategory category) {
    _tv[category] = null;
    _error[category] = null;
    _isLoading[category] = false;
    _isFetchingMore[category] = false;
    notifyListeners();
  }
}
