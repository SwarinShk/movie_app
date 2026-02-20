import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_list.dart';
import 'package:provider/provider.dart';

class MovieHorizontalList extends StatelessWidget {
  final MovieCategory category;

  const MovieHorizontalList({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        final data = provider.movies(category);
        final movies = data?.results ?? [];
        final isLoading = provider.isLoading(category);

        final displayMovies = movies.take(10).toList();

        if (isLoading && movies.isEmpty) {
          return const SizedBox(
            height: 240,
            child: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        }

        if (displayMovies.isEmpty) {
          return const SizedBox(
            height: 240,
            child: Center(
              child: Text(
                "No movies available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return MovieList(
          onMovieItemTap: (movie) {
            context.push('/moviedetail/${movie.id}');
          },
          movies: movies,
        );
      },
    );
  }
}
