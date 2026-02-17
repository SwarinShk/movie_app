import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/models/movie_category_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSwiper extends StatelessWidget {
  final MovieCategory category;
  final double height;

  const MovieSwiper({required this.category, this.height = 220, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        final isLoading = provider.isLoading[category] ?? true;
        final movies = provider.movies[category] ?? [];
        final displayMovies = movies.take(10).toList();
        if (isLoading) {
          return SizedBox(
            height: height,
            child: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        } else {
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
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    context.push('/moviedetail/${movie.id}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: movie.posterPath != null
                            ? NetworkImage(
                                "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                              )
                            : AssetImage('assets/images/image_not_found.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
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
                          if (movie.releaseDate != null)
                            Text(
                              'On ${DateFormat('MMMM d, yyyy').format(DateTime.parse(movie.releaseDate!))}',
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
        }
      },
    );
  }
}
