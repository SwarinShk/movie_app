import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/search/presentation/widgets/search_tab_content.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:movie_app/features/search/presentation/providers/search_provider.dart';
import 'package:movie_app/common/widgets/appbar/search_appbar.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<SearchProvider>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        provider.hasMorePages &&
        !provider.isFetchingMore) {
      provider.loadMore();
    }
  }

  void _onChanged(String value, SearchProvider provider) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = value.trim();
      if (query.isNotEmpty) {
        provider.fetchSearch(query);
      } else {
        provider.clear();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, _) {
        final results = provider.search?.results ?? [];

        final movies = results
            .where((e) => e.mediaType == MediaType.movie)
            .toList();
        final tvShows = results
            .where((e) => e.mediaType == MediaType.tv)
            .toList();
        final persons = results
            .where((e) => e.mediaType == MediaType.person)
            .toList();

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: SearchAppBar(
              controller: _controller,
              onChanged: (_) => _onChanged(_controller.text, provider),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  TabBar(
                    indicatorWeight: 1,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: AppColor.redAccent),
                    ),
                    dividerColor: AppColor.dark,
                    labelStyle: AppTextStyle.h5Medium.copyWith(
                      color: AppColor.redAccent,
                    ),
                    unselectedLabelStyle: AppTextStyle.h5Medium.copyWith(
                      color: AppColor.white,
                    ),
                    tabs: [
                      Tab(text: 'Movies'),
                      Tab(text: 'TV Shows'),
                      Tab(text: 'People'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SearchTabContent(
                          items: movies,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMore,
                          query: _controller.text,
                          isPersonTab: false,
                          scrollController: _scrollController,
                        ),
                        SearchTabContent(
                          items: tvShows,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMore,
                          query: _controller.text,
                          isPersonTab: false,
                          scrollController: _scrollController,
                        ),
                        SearchTabContent(
                          items: persons,
                          isLoading: provider.isLoading,
                          isFetchingMore: provider.isFetchingMore,
                          query: _controller.text,
                          isPersonTab: true,
                          scrollController: _scrollController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
