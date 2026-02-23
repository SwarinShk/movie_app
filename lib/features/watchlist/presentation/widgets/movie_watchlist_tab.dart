import 'package:flutter/material.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/button/primary_icon_button.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_list_item.dart';
import 'package:movie_app/features/watchlist/presentation/providers/watchlist_provider.dart';
import 'package:provider/provider.dart';

class MovieWatchlistTab extends StatelessWidget {
  final List<Movie> items;
  final bool isLoading;
  final bool isFetchingMore;
  final ScrollController scrollController;

  const MovieWatchlistTab({
    required this.items,
    required this.isLoading,
    required this.isFetchingMore,
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
      return Center(
        child: Column(
          spacing: 15,
          mainAxisAlignment: .center,
          children: [
            Text(
              'Movies Watchlist list is empty',
              style: AppTextStyle.h4Medium.copyWith(color: AppColor.white),
            ),
            PrimaryIconButton(
              label: 'Refresh',
              icon: Icons.refresh,
              onPressed: () async {
                await context.read<WatchlistProvider>().fetchMovieWatchlist(
                  initialLoad: true,
                  reset: true,
                );
              },
            ),
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await context.read<WatchlistProvider>().fetchMovieWatchlist(
            initialLoad: true,
            reset: true,
          );
        },
        child: ListView.separated(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
        ),
      );
    }
  }
}
