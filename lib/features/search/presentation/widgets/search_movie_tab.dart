import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_list_item.dart';
import 'package:movie_app/features/search/presentation/widgets/empty_search_state.dart';

class SearchMovieTab extends StatelessWidget {
  final List<Movie> items;
  final bool isLoading;
  final bool isFetchingMore;
  final String query;
  final ScrollController scrollController;

  const SearchMovieTab({
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
          return MovieListItem(movie: item);
        },
      );
    }
  }
}
