import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:movie_app/features/favorite/presentation/widgets/movie_favorite_tab.dart';
import 'package:movie_app/features/favorite/presentation/widgets/tv_favorite_tab.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController _movieScrollController = ScrollController();
  final ScrollController _tvScrollController = ScrollController();

  void _initFetch() {
    Future.microtask(() {
      if (!mounted) return;
      final provider = context.read<FavoriteProvider>();
      provider.fetchMovieFavorite(initialLoad: true);
      provider.fetchTvFavorite(initialLoad: true);
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
    final provider = context.read<FavoriteProvider>();
    if (_movieScrollController.position.pixels >=
            _movieScrollController.position.maxScrollExtent - 300 &&
        !provider.isFetchingMoreMovies &&
        !provider.isLoading) {
      provider.fetchMovieFavorite(initialLoad: false);
    }
  }

  void _onTvScroll() {
    final provider = context.read<FavoriteProvider>();
    if (_tvScrollController.position.pixels >=
            _tvScrollController.position.maxScrollExtent - 300 &&
        !provider.isFetchingMoreTv &&
        !provider.isLoading) {
      provider.fetchTvFavorite(initialLoad: false);
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
        appBar: CustomAppBar(
          leading: Icons.chevron_left,
          onLeadingPressed: () {
            context.pop();
          },
          title: 'Favorites',
        ),
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
                child: Consumer<FavoriteProvider>(
                  builder: (context, provider, _) {
                    final movieItems = provider.movieFavorite?.results ?? [];
                    final tvItems = provider.tvFavorite?.results ?? [];

                    return TabBarView(
                      children: [
                        MovieFavoriteTab(
                          items: movieItems,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMoreMovies,
                          scrollController: _movieScrollController,
                        ),
                        TvFavoriteTab(
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
