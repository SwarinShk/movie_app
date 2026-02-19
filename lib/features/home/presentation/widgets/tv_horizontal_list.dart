import 'package:flutter/material.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
import 'package:provider/provider.dart';

class TvHorizontalList extends StatelessWidget {
  final TvCategory category;

  const TvHorizontalList({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TvProvider>(
      builder: (context, provider, _) {
        final data = provider.tvs(category);
        final tvs = data?.results ?? [];
        final isLoading = provider.isLoading(category);

        final displaytvs = tvs.take(10).toList();

        if (isLoading && tvs.isEmpty) {
          return const SizedBox(
            height: 240,
            child: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        }

        if (displaytvs.isEmpty) {
          return const SizedBox(
            height: 240,
            child: Center(
              child: Text(
                "No tv shows available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: displaytvs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final tv = displaytvs[index];

              return GestureDetector(
                onTap: () {},
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
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: tv.posterPath.isNotEmpty
                                  ? NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${tv.posterPath}",
                                    )
                                  : const AssetImage(
                                          'assets/images/image_not_found.png',
                                        )
                                        as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
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
      },
    );
  }
}
