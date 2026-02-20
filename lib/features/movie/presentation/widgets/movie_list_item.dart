import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/badge/meta_item.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/utils/formatters.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/moviedetail/${movie.id}');
      },
      child: Row(
        children: [
          // Movie poster + rating badge
          Container(
            height: 160,
            width: 125,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: movie.posterPath != null && movie.posterPath!.isNotEmpty
                    ? NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      )
                    : const AssetImage('assets/images/image_not_found.png')
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: RatingBadge(rating: movie.voteAverage),
            ),
          ),
          const SizedBox(width: 15),
          // Movie details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Movie title
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.h5SemiBold.copyWith(
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(height: 4),
                // Movie overview
                Text(
                  movie.overview.isNotEmpty == true
                      ? movie.overview
                      : 'No description available.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.h5Regular.copyWith(
                    color: AppColor.whiteGrey,
                  ),
                ),
                const SizedBox(height: 8),
                // Release year
                MetaItem(
                  icon: Icons.calendar_month_rounded,
                  text: getReleaseYear(movie.releaseDate),
                ),
                const SizedBox(height: 8),
                // Adult rating badge
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: movie.adult == true
                          ? AppColor.redAccent
                          : AppColor.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: Text(
                      movie.adult == true ? 'R-rated' : 'PG-13',
                      style: AppTextStyle.h6Medium.copyWith(
                        color: movie.adult == true
                            ? AppColor.redAccent
                            : AppColor.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
