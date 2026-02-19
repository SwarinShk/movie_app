import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_meta_item.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class TvListItem extends StatelessWidget {
  final Result tv;

  const TvListItem({required this.tv, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            height: 160,
            width: 125,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: tv.posterPath.isNotEmpty
                    ? NetworkImage(
                        'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                      )
                    : const AssetImage('assets/images/image_not_found.png')
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: RatingBadge(rating: tv.voteAverage),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tv.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.h5SemiBold.copyWith(
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tv.overview.isNotEmpty == true
                      ? tv.overview
                      : 'No description available.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.h5Regular.copyWith(
                    color: AppColor.whiteGrey,
                  ),
                ),
                const SizedBox(height: 8),
                MovieMetaItem(
                  icon: Icons.calendar_month_rounded,
                  text: _getReleaseYear(tv.firstAirDate.toString()),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: tv.adult == true
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
                      tv.adult == true ? 'R-rated' : 'PG-13',
                      style: AppTextStyle.h6Medium.copyWith(
                        color: tv.adult == true
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

  String _getReleaseYear(String? releaseDate) {
    if (releaseDate != null && releaseDate.isNotEmpty) {
      try {
        return DateFormat.y().format(DateTime.parse(releaseDate));
      } catch (_) {
        return 'Unknown';
      }
    }
    return 'Unknown';
  }
}
