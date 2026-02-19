import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/search/presentation/widgets/empty_search_state.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_list_item.dart';

class SearchTvTab extends StatelessWidget {
  final List<Result> items;
  final bool isLoading;
  final bool isFetchingMore;
  final String query;
  final ScrollController scrollController;

  const SearchTvTab({
    required this.items,
    required this.isLoading,
    required this.isFetchingMore,
    required this.query,
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
          return TvListItem(tv: item);
        },
      );
    }
  }
}
