import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/common/widgets/button/custom_icon_button.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/widgets/avatar/horizontal_list.dart';
import 'package:movie_app/common/widgets/indicator/meta_divider.dart';
import 'package:movie_app/common/widgets/badge/meta_item.dart';
import 'package:movie_app/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_detail_provider.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_list.dart';
import 'package:movie_app/features/watchlist/presentation/providers/watchlist_provider.dart';
import 'package:movie_app/utils/formatters.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class TvDetailScreen extends StatefulWidget {
  final int tvId;

  const TvDetailScreen({required this.tvId, super.key});

  @override
  State<TvDetailScreen> createState() => _TvDetailScreenState();
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TvDetailProvider>().fetchTvDetail(widget.tvId);
        context.read<TvDetailProvider>().fetchTvCredit(widget.tvId);
        context.read<TvDetailProvider>().fetchSimilar(widget.tvId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvDetailProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        } else if (provider.tv == null) {
          return Scaffold(
            appBar: CustomAppBar(
              leading: Icons.chevron_left,
              onLeadingPressed: () {
                context.pop();
              },
              title: '',
            ),
            body: Center(
              child: Text(
                "TV Show not found",
                style: AppTextStyle.h4Medium.copyWith(color: AppColor.white),
              ),
            ),
          );
        } else {
          final tv = provider.tv!;
          final similar = provider.similar ?? [];

          return Scaffold(
            appBar: CustomAppBar(
              leading: Icons.chevron_left,
              onLeadingPressed: () => context.pop(),
              title: tv.name,
              actions: [
                Consumer<WatchlistProvider>(
                  builder: (_, provider, _) {
                    final inWatchlist = provider.isTvInWatchlist(tv.id);

                    return CustomIconButton(
                      icon: inWatchlist
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      iconColor: inWatchlist
                          ? AppColor.redAccent
                          : AppColor.grey,
                      onPressed: () async {
                        await provider.toggleWatchlist(
                          mediaId: tv.id,
                          mediaType: "tv",
                          isInWatchlist: inWatchlist,
                        );
                        provider.fetchAll(reset: true);
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Consumer<FavoriteProvider>(
                    builder: (_, provider, _) {
                      final inFavorite = provider.isTvInFavorite(tv.id);

                      return CustomIconButton(
                        icon: inFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        iconColor: inFavorite
                            ? AppColor.redAccent
                            : AppColor.grey,
                        onPressed: () async {
                          await provider.toggleFavorite(
                            mediaId: tv.id,
                            mediaType: 'tv',
                            isInFavorite: inFavorite,
                          );
                          provider.fetchAll(reset: true);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final posterWidth = maxWidth * 0.45;
                  final posterHeight = posterWidth * 1.4;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: tv.posterPath != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                    fit: BoxFit.cover,
                                    width: posterWidth,
                                    height: posterHeight,
                                  )
                                : Image.asset(
                                    'assets/images/image_not_found.png',
                                    fit: BoxFit.cover,
                                    width: posterWidth,
                                    height: posterHeight,
                                  ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Wrap(
                            alignment: .center,
                            spacing: 10,
                            runSpacing: 5,
                            children: [
                              MetaItem(
                                icon: Icons.calendar_month_rounded,
                                text: getReleaseYear(
                                  tv.firstAirDate.toString(),
                                ),
                              ),
                              MetaDivider(),
                              MetaItem(
                                icon: Icons.access_time_filled_rounded,
                                text: tv.episodeRunTime.isNotEmpty
                                    ? '${tv.episodeRunTime.first} min'
                                    : 'N/A',
                              ),
                              MetaDivider(),
                              MetaItem(
                                icon: Icons.movie_creation_rounded,
                                text: tv.genres.isNotEmpty
                                    ? tv.genres.first.name
                                    : 'N/A',
                              ),
                              MetaDivider(),
                              MetaItem(
                                icon: Icons.tv,
                                text: tv.numberOfSeasons == 1
                                    ? "1 Season"
                                    : "${tv.numberOfSeasons} Seasons",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(child: RatingBadge(rating: tv.voteAverage)),
                        SizedBox(height: 30),
                        Text(
                          'Movie Overview',
                          style: AppTextStyle.h4SemiBold.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReadMoreText(
                          tv.overview,
                          trimCollapsedText: ' show more',
                          trimExpandedText: ' show less',
                          style: AppTextStyle.h5Regular.copyWith(
                            color: AppColor.whiteGrey,
                          ),
                          moreStyle: AppTextStyle.h5Regular.copyWith(
                            color: AppColor.redAccent,
                          ),
                          lessStyle: AppTextStyle.h5Regular.copyWith(
                            color: AppColor.grey,
                          ),
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                        ),
                        if (provider.credit != null &&
                            provider.credit!.cast.isNotEmpty) ...[
                          Builder(
                            builder: (_) {
                              final credit = provider.credit!;

                              return Column(
                                mainAxisSize: .min,
                                crossAxisAlignment: .start,
                                children: [
                                  SizedBox(height: 25),
                                  Text(
                                    'Cast and Crew',
                                    style: AppTextStyle.h4SemiBold.copyWith(
                                      color: AppColor.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 60,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credit.cast.length,
                                      separatorBuilder: (_, _) =>
                                          const SizedBox(width: 12),
                                      itemBuilder: (context, index) {
                                        final cast = credit.cast[index];

                                        return HorizontalItem(
                                          backgroundImage:
                                              cast.profilePath != null
                                              ? NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500${cast.profilePath}',
                                                )
                                              : const AssetImage(
                                                  'assets/images/image_not_found.png',
                                                ),
                                          name: cast.name,
                                          description: cast.knownForDepartment,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                        if (tv.productionCompanies.isNotEmpty) ...[
                          SizedBox(height: 25),
                          Text(
                            'Production Companies',
                            style: AppTextStyle.h4SemiBold.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: tv.productionCompanies.length,
                              separatorBuilder: (_, _) => SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final production =
                                    tv.productionCompanies[index];

                                return HorizontalItem(
                                  backgroundImage: production.logoPath != null
                                      ? NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${production.logoPath}',
                                        )
                                      : AssetImage(
                                          'assets/images/image_not_found.png',
                                        ),
                                  name: production.name,
                                  description: production.originCountry,
                                );
                              },
                            ),
                          ),
                        ],
                        if (similar.isNotEmpty) ...[
                          SizedBox(height: 25),
                          Text(
                            'Similar Movies',
                            style: AppTextStyle.h4SemiBold.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          TvList(tvs: similar),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
