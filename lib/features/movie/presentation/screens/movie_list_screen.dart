import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/utils/formatters.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_list_item.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MovieProvider>();

      // Fetch only if data is null
      if (provider.movies(widget.category) == null) {
        provider.fetchMovies(widget.category);
      }
    });

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
        final data = provider.movies(widget.category);
        final movies = data?.results ?? [];
        final isLoading = provider.isLoading(widget.category);
        final isFetchingMore = provider.isFetchingMore(widget.category);
        final error = provider.error(widget.category);

        return Scaffold(
          appBar: CustomAppBar(
            leading: Icons.chevron_left,
            onLeadingPressed: () => context.pop(),
            title: widget.category.title.toTitleCase,
          ),
          body: SafeArea(
            child: Builder(
              builder: (_) {
                // Initial Loading
                if (isLoading && movies.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.white),
                  );
                }

                // Error State
                if (error != null && movies.isEmpty) {
                  return Center(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                // List
                return ListView.separated(
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
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
                        ),
                      );
                    }

                    final movie = movies[index];
                    return MovieListItem(movie: movie);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
