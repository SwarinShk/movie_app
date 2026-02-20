import 'package:flutter/widgets.dart';
import 'package:movie_app/features/tv/data/models/tv_credits_model.dart';
import 'package:movie_app/features/tv/data/models/tv_detail_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';
import 'package:movie_app/features/tv/data/services/tv_service.dart';

class TvDetailProvider extends ChangeNotifier {
  final TvService _service = TvService();

  TvDetail? _tv;
  TvCredits? _credit;
  List<Result>? _similar;

  bool _isLoading = false;
  String? _error;

  TvDetail? get tv => _tv;
  TvCredits? get credit => _credit;
  List<Result>? get similar => _similar;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTvDetail(int tvId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchTvDetail(tvId);

      _tv = response;
    } catch (e) {
      _error = e.toString();

      _tv = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTvCredit(int tvId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchTvCredit(tvId);

      _credit = response;
    } catch (e) {
      _error = e.toString();

      _credit = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSimilar(int tvId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchSimilar(tvId);

      _similar = response.results;
    } catch (e) {
      _error = e.toString();

      _similar = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
