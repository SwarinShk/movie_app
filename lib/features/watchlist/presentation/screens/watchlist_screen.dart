import 'package:flutter/material.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/watchlist/presentation/providers/watchlist_provider.dart';
import 'package:movie_app/features/watchlist/presentation/widgets/movie_watchlist_tab.dart';
import 'package:movie_app/features/watchlist/presentation/widgets/tv_watchlist_tab.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final ScrollController _movieScrollController = ScrollController();
  final ScrollController _tvScrollController = ScrollController();

  void _initFetch() {
    Future.microtask(() {
      if (!mounted) return;
      final provider = context.read<WatchlistProvider>();
      provider.fetchMovieWatchlist(initialLoad: true);
      provider.fetchTvWatchlist(initialLoad: true);
    });
  }

  @override
  void initState() {
    super.initState();

    _movieScrollController.addListener(_onMovieScroll);
    _tvScrollController.addListener(_onTvScroll);

    _initFetch();
  }

  void _onMovieScroll() {
    final provider = context.read<WatchlistProvider>();
    if (_movieScrollController.position.pixels >=
            _movieScrollController.position.maxScrollExtent - 300 &&
        !provider.isFetchingMoreMovies &&
        !provider.isLoading) {
      provider.fetchMovieWatchlist(initialLoad: false);
    }
  }

  void _onTvScroll() {
    final provider = context.read<WatchlistProvider>();
    if (_tvScrollController.position.pixels >=
            _tvScrollController.position.maxScrollExtent - 300 &&
        !provider.isFetchingMoreTv &&
        !provider.isLoading) {
      provider.fetchTvWatchlist(initialLoad: false);
    }
  }

  @override
  void dispose() {
    _movieScrollController.removeListener(_onMovieScroll);
    _tvScrollController.removeListener(_onTvScroll);
    _movieScrollController.dispose();
    _tvScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Watchlist'),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorWeight: 1,
                dividerColor: AppColor.dark,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColor.redAccent, width: 2),
                ),
                labelStyle: AppTextStyle.h5Medium.copyWith(
                  color: AppColor.redAccent,
                ),
                unselectedLabelStyle: AppTextStyle.h5Medium.copyWith(
                  color: AppColor.white,
                ),
                tabs: const [
                  Tab(text: 'Movies'),
                  Tab(text: 'TV Shows'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<WatchlistProvider>(
                  builder: (context, provider, _) {
                    final movieItems = provider.movieWatchlist?.results ?? [];
                    final tvItems = provider.tvWatchlist?.results ?? [];

                    return TabBarView(
                      children: [
                        MovieWatchlistTab(
                          items: movieItems,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMoreMovies,
                          scrollController: _movieScrollController,
                        ),
                        TvWatchlistTab(
                          items: tvItems,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMoreTv,
                          scrollController: _tvScrollController,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
