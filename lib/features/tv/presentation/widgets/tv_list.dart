import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class TvList extends StatelessWidget {
  final List<Result> tvs;
  final void Function(Result tv)? onTvItemTap;

  const TvList({required this.tvs, this.onTvItemTap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tvs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return GestureDetector(
            onTap: () => onTvItemTap?.call(tv),
            child: Container(
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
                          image: tv.posterPath.isNotEmpty
                              ? NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${tv.posterPath}",
                                )
                              : AssetImage('assets/images/image_not_found.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: RatingBadge(rating: tv.voteAverage),
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
                          tv.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.h5SemiBold.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tv.overview,
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
            ),
          );
        },
      ),
    );
  }
}
