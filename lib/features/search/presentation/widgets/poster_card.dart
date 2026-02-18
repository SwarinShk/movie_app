import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_meta_item.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';

class PosterCard extends StatelessWidget {
  final SearchResult item;

  const PosterCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/itemdetail/${item.id}');
      },
      child: Row(
        children: [
          Container(
            height: 160,
            width: 125,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: item.posterPath != null
                    ? NetworkImage(
                        'https://image.tmdb.org/t/p/w500${item.posterPath}',
                      )
                    : AssetImage('assets/images/image_not_found.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: RatingBadge(rating: item.voteAverage!),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              spacing: 12,
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  item.displayTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.h5SemiBold.copyWith(
                    color: AppColor.white,
                  ),
                ),
                Text(
                  item.overview!,
                  style: AppTextStyle.h5Regular.copyWith(
                    color: AppColor.whiteGrey,
                  ),
                  maxLines: 2,
                ),
                MovieMetaItem(
                  icon: Icons.calendar_month_rounded,
                  text: item.displayDate,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: item.adult ? AppColor.redAccent : AppColor.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: Text(
                      item.adult ? 'R-rated' : 'PG-13',
                      style: AppTextStyle.h6Medium.copyWith(
                        color: item.adult ? AppColor.redAccent : AppColor.green,
                      ),
                      maxLines: 2,
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
