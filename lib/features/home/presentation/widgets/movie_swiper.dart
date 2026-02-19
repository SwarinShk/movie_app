import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';
import 'package:provider/provider.dart';

class MovieSwiper extends StatelessWidget {
  final MovieCategory category;
  final double height;

  const MovieSwiper({required this.category, this.height = 220, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        final data = provider.movies(category);
        final isLoading = provider.isLoading(category);
        final movies = data?.results ?? [];

        final displayMovies = movies.take(10).toList();

        if (isLoading && movies.isEmpty) {
          return SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        }

        if (displayMovies.isEmpty) {
          return SizedBox(
            height: height,
            child: const Center(
              child: Text(
                "No movies available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return SizedBox(
          height: height,
          child: Swiper(
            autoplay: true,
            itemCount: displayMovies.length,
            outer: true,
            pagination: SwiperPagination(
              builder: RectSwiperPaginationBuilder(
                activeColor: AppColor.redAccent,
                color: AppColor.darkGrey,
              ),
            ),
            itemBuilder: (context, index) {
              final movie = displayMovies[index];

              return GestureDetector(
                onTap: () {
                  context.push('/moviedetail/${movie.id}');
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: movie.backdropPath != null
                          ? NetworkImage(
                              "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                            )
                          : const AssetImage(
                                  'assets/images/image_not_found.png',
                                )
                                as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: AppTextStyle.h4SemiBold.copyWith(
                            color: AppColor.google,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Safe Date Parsing
                        if (movie.releaseDate != null &&
                            movie.releaseDate!.isNotEmpty)
                          Text(
                            'On ${_formatDate(movie.releaseDate!)}',
                            style: AppTextStyle.h6Medium.copyWith(
                              color: AppColor.google,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _formatDate(String rawDate) {
    try {
      final parsed = DateTime.parse(rawDate);
      return DateFormat('MMMM d, yyyy').format(parsed);
    } catch (_) {
      return rawDate;
    }
  }
}
