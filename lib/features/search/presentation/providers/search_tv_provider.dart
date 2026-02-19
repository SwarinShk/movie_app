import 'package:flutter/widgets.dart';
import 'package:movie_app/features/search/data/services/search_service.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class SearchTvProvider extends ChangeNotifier {
  final SearchService _service = SearchService();

  TvModel? _searchTv;

  bool _isLoading = false;
  bool _isFetchingMore = false;
  String? _error;

  String _currentQuery = '';
  int _currentPage = 1;
  int _totalPages = 1;

  int _requestId = 0;

  TvModel? get searchTv => _searchTv;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  String? get error => _error;
  bool get hasMorePages => _currentPage < _totalPages;

  Future<void> fetchSearch(String text) async {
    final query = text.trim();
    if (query.isEmpty) return;

    if (query == _currentQuery && _searchTv != null) return;

    _requestId++;
    final currentRequest = _requestId;

    _isLoading = true;
    _error = null;
    _currentQuery = query;
    _currentPage = 1;
    _totalPages = 1;
    notifyListeners();

    try {
      final response = await _service.searchTv(query, page: _currentPage);

      if (currentRequest != _requestId) return;

      _searchTv = response;
      _totalPages = response.totalPages;
    } catch (e) {
      if (currentRequest != _requestId) return;
      _error = e.toString();
      _searchTv = null;
    } finally {
      if (currentRequest == _requestId) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadMore() async {
    if (_isFetchingMore ||
        _isLoading ||
        !hasMorePages ||
        _currentQuery.isEmpty) {
      return;
    }

    _isFetchingMore = true;
    _error = null;
    notifyListeners();

    final nextPage = _currentPage + 1;

    try {
      final response = await _service.searchTv(_currentQuery, page: nextPage);

      if (_searchTv != null) {
        _searchTv = _searchTv!.merge(response);
        _currentPage = nextPage;
        _totalPages = response.totalPages;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  void clear() {
    _searchTv = null;
    _currentQuery = '';
    _currentPage = 1;
    _totalPages = 1;
    _error = null;
    _isLoading = false;
    _isFetchingMore = false;
    notifyListeners();
  }
}
