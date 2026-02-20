import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/search/presentation/widgets/search_appbar.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/search/presentation/providers/search_movie_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_person_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_tv_provider.dart';
import 'package:movie_app/features/search/presentation/widgets/search_movie_tab.dart';
import 'package:movie_app/features/search/presentation/widgets/search_person_tab.dart';
import 'package:movie_app/features/search/presentation/widgets/search_tv_tab.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _movieScrollController = ScrollController();
  final ScrollController _tvScrollController = ScrollController();
  final ScrollController _personScrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _movieScrollController.addListener(_onMovieScroll);
    _tvScrollController.addListener(_onTvScroll);
    _personScrollController.addListener(_onPersonScroll);
  }

  @override
  void dispose() {
    _movieScrollController.removeListener(_onMovieScroll);
    _movieScrollController.dispose();

    _tvScrollController.removeListener(_onTvScroll);
    _tvScrollController.dispose();

    _personScrollController.removeListener(_onPersonScroll);
    _personScrollController.dispose();

    _textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final movieProvider = context.read<SearchMovieProvider>();
      final tvProvider = context.read<SearchTvProvider>();
      final personProvider = context.read<SearchPersonProvider>();

      if (query.isEmpty) {
        movieProvider.clear();
        tvProvider.clear();
        personProvider.clear();
      } else {
        movieProvider.fetchSearch(query);
        tvProvider.fetchSearch(query);
        personProvider.fetchSearch(query);
      }
    });
  }

  void _onMovieScroll() {
    if (!_movieScrollController.hasClients) return;

    final maxScroll = _movieScrollController.position.maxScrollExtent;
    final currentScroll = _movieScrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      final provider = context.read<SearchMovieProvider>();
      if (!provider.isFetchingMore) {
        provider.loadMore();
      }
    }
  }

  void _onTvScroll() {
    if (!_tvScrollController.hasClients) return;

    final maxScroll = _tvScrollController.position.maxScrollExtent;
    final currentScroll = _tvScrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      final provider = context.read<SearchTvProvider>();
      if (!provider.isFetchingMore) {
        provider.loadMore();
      }
    }
  }

  void _onPersonScroll() {
    if (!_personScrollController.hasClients) return;

    final maxScroll = _personScrollController.position.maxScrollExtent;
    final currentScroll = _personScrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      final provider = context.read<SearchPersonProvider>();
      if (!provider.isFetchingMore) {
        provider.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: SearchAppBar(
          controller: _textController,
          onChanged: _onSearchTextChanged,
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorWeight: 1,
                dividerColor: AppColor.dark,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColor.redAccent),
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
                  Tab(text: 'People'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    Consumer<SearchMovieProvider>(
                      builder: (context, movieProvider, _) {
                        return SearchMovieTab(
                          query: _textController.text,
                          items: movieProvider.searchMovie?.results ?? [],
                          isLoading: movieProvider.isLoading,
                          isFetchingMore: movieProvider.isFetchingMore,
                          scrollController: _movieScrollController,
                        );
                      },
                    ),
                    Consumer<SearchTvProvider>(
                      builder: (context, tvProvider, _) {
                        return SearchTvTab(
                          query: _textController.text,
                          items: tvProvider.searchTv?.results ?? [],
                          isLoading: tvProvider.isLoading,
                          isFetchingMore: tvProvider.isFetchingMore,
                          scrollController: _tvScrollController,
                        );
                      },
                    ),
                    Consumer<SearchPersonProvider>(
                      builder: (context, personProvider, _) {
                        return SearchPeopleTab(
                          query: _textController.text,
                          items: personProvider.searchPerson?.results ?? [],
                          isLoading: personProvider.isLoading,
                          isFetchingMore: personProvider.isFetchingMore,
                          scrollController: _personScrollController,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
