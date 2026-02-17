import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/models/paginated_movie_model.dart';
import 'package:movie_app/shared/badge/rating_badge.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            width: 150,
            decoration: BoxDecoration(
              color: AppColor.soft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: movie.posterPath != null
                            ? NetworkImage(
                                "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              )
                            : AssetImage('assets/images/image_not_found.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: RatingBadge(rating: movie.voteAverage),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.h5SemiBold.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        movie.overview,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.h6Medium.copyWith(
                          color: AppColor.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
