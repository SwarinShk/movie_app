import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/helpers/text_helper/text_helper.dart';
import 'package:movie_app/features/v1/movies/widget/movie_list_item.dart';
import 'package:movie_app/models/movie_category_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/shared/appbar/custom_appbar.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  final MovieCategory category;

  const MovieListScreen({required this.category, super.key});
  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = context.read<MovieProvider>();

    // Initial fetch only if empty
    if ((provider.movies[widget.category] ?? []).isEmpty) {
      provider.fetchMovies(widget.category);
    }

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<MovieProvider>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.fetchNextPage(widget.category);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        final movies = provider.movies[widget.category] ?? [];
        final isLoading = provider.isLoading[widget.category] ?? false;
        final isFetchingMore =
            provider.isFetchingMore[widget.category] ?? false;

        return Scaffold(
          appBar: CustomAppBar(
            leading: Icons.chevron_left,
            onLeadingPressed: () => context.pop(),
            title: widget.category.title.toTitleCase,
          ),
          body: SafeArea(
            child: isLoading && movies.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    itemCount: movies.length + (isFetchingMore ? 1 : 0),
                    separatorBuilder: (_, _) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      // Bottom Loader
                      if (index >= movies.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(
                              color: AppColor.white,
                            ),
                          ),
                        );
                      }

                      final movie = movies[index];
                      return MovieListItem(movie: movie);
                    },
                  ),
          ),
        );
      },
    );
  }
}
