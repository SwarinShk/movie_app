import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/search/presentation/widgets/empty_search_state.dart';
import 'package:movie_app/features/search/presentation/widgets/person_card.dart';
import 'package:movie_app/features/search/presentation/widgets/poster_card.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';

class SearchTabContent extends StatelessWidget {
  final List<SearchResult> items;
  final bool isLoading;
  final bool isFetchingMore;
  final String query;
  final bool isPersonTab;
  final ScrollController scrollController;

  const SearchTabContent({
    required this.items,
    required this.isLoading,
    required this.isFetchingMore,
    required this.query,
    required this.isPersonTab,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.white),
      );
    } else if (items.isEmpty && !isLoading) {
      return EmptySearchState(query: query);
    } else {
      return ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: items.length + (isFetchingMore ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(height: 15),
        itemBuilder: (context, index) {
          if (index == items.length) {
            // Loader at bottom
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: CircularProgressIndicator(color: AppColor.white),
              ),
            );
          }

          final item = items[index];
          return isPersonTab ? PersonCard(item: item) : PosterCard(item: item);
        },
      );
    }
  }
}
