import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_detail_provider.dart';
import 'package:movie_app/common/widgets/avatar/horizontal_list.dart';
import 'package:movie_app/common/widgets/indicator/meta_divider.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_list.dart';
import 'package:movie_app/common/widgets/badge/meta_item.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/common/widgets/badge/rating_badge.dart';
import 'package:movie_app/common/widgets/button/custom_icon_button.dart';
import 'package:movie_app/features/wishlist/presentation/providers/watchlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({required this.movieId, super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<MovieDetailProvider>().fetchMovieDetail(widget.movieId);
        context.read<MovieDetailProvider>().fetchMovieCredit(widget.movieId);
        context.read<MovieDetailProvider>().fetchSimilar(widget.movieId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        } else if (provider.movie == null) {
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
                "Movie not found",
                style: AppTextStyle.h4Medium.copyWith(color: AppColor.white),
              ),
            ),
          );
        } else {
          final movie = provider.movie!;
          final recommended = provider.recommended ?? [];

          return Scaffold(
            appBar: CustomAppBar(
              leading: Icons.chevron_left,
              onLeadingPressed: () => context.pop(),
              title: movie.title,
              actions: [
                Consumer<WatchlistProvider>(
                  builder: (_, provider, _) {
                    final inWatchlist = provider.isMovieInWatchlist(movie.id);
                    return CustomIconButton(
                      icon: inWatchlist
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      iconColor: inWatchlist ? Colors.red : Colors.grey,
                      onPressed: () async {
                        await provider.toggleWatchlist(
                          mediaId: movie.id,
                          mediaType: "movie",
                          isInWatchlist: inWatchlist,
                        );
                        provider.fetchAll(reset: true);
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CustomIconButton(onPressed: () {}),
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
                            child: movie.posterPath != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                                text: DateFormat.y().format(
                                  DateTime.parse(movie.releaseDate),
                                ),
                              ),
                              MetaDivider(),
                              MetaItem(
                                icon: Icons.access_time_filled_rounded,
                                text: '${movie.runtime} min',
                              ),
                              MetaDivider(),
                              MetaItem(
                                icon: Icons.movie_creation_rounded,
                                text: movie.genres.isNotEmpty
                                    ? movie.genres.first.name
                                    : 'N/A',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(child: RatingBadge(rating: movie.voteAverage)),
                        SizedBox(height: 30),
                        Text(
                          'Movie Overview',
                          style: AppTextStyle.h4SemiBold.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReadMoreText(
                          movie.overview,
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
                        if (movie.productionCompanies.isNotEmpty) ...[
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
                              itemCount: movie.productionCompanies.length,
                              separatorBuilder: (_, _) => SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final production =
                                    movie.productionCompanies[index];

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
                        if (recommended.isNotEmpty) ...[
                          SizedBox(height: 25),
                          Text(
                            'Similar Movies',
                            style: AppTextStyle.h4SemiBold.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          MovieList(movies: recommended),
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
