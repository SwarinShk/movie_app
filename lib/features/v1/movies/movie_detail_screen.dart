import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/features/v1/movies/widget/horizontal_list.dart';
import 'package:movie_app/features/v1/movies/widget/meta_divider.dart';
import 'package:movie_app/features/v1/movies/widget/movie_meta_item.dart';
import 'package:movie_app/features/v1/movies/widget/movie_list.dart';
import 'package:movie_app/providers/movie_detail_provider.dart';
import 'package:movie_app/shared/appbar/custom_appbar.dart';
import 'package:movie_app/shared/badge/rating_badge.dart';
import 'package:movie_app/shared/button/custom_icon_button.dart';
import 'package:provider/provider.dart';

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
        } else if (provider.movie == null || provider.credit == null) {
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
          final credit = provider.credit!;
          final recommended = provider.recommended ?? [];

          return Scaffold(
            appBar: CustomAppBar(
              leading: Icons.chevron_left,
              onLeadingPressed: () => context.pop(),
              title: movie.title,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
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
                  final horizontalPadding = maxWidth * 0.04;
                  final spacing = maxWidth * 0.03;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: spacing),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                              width: posterWidth,
                              height: posterHeight,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),
                        Center(
                          child: Wrap(
                            alignment: .center,
                            spacing: spacing,
                            runSpacing: spacing / 2,
                            children: [
                              MovieMetaItem(
                                icon: Icons.calendar_month_rounded,
                                text: DateFormat.y().format(
                                  DateTime.parse(movie.releaseDate),
                                ),
                              ),
                              MetaDivider(),
                              MovieMetaItem(
                                icon: Icons.access_time_filled_rounded,
                                text: '${movie.runtime} min',
                              ),
                              MetaDivider(),
                              MovieMetaItem(
                                icon: Icons.movie_creation_rounded,
                                text: movie.genres.isNotEmpty
                                    ? movie.genres.first.name
                                    : 'N/A',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing),
                        Center(child: RatingBadge(rating: movie.voteAverage)),
                        SizedBox(height: spacing),
                        Text(
                          'Movie Overview',
                          style: AppTextStyle.h4SemiBold.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          movie.overview,
                          style: AppTextStyle.h5Regular.copyWith(
                            color: AppColor.whiteGrey,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          'Cast and Crew',
                          style: AppTextStyle.h4SemiBold.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: spacing),
                        SizedBox(
                          height: 60,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: credit.cast.length,
                            separatorBuilder: (_, _) => SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final crew = credit.cast[index];

                              return HorizontalItem(
                                backgroundImage: crew.profilePath != null
                                    ? NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${crew.profilePath}',
                                      )
                                    : AssetImage(
                                        'assets/images/image_not_found.png',
                                      ),
                                name: crew.name,
                                description: crew.knownForDepartment,
                              );
                            },
                          ),
                        ),
                        if (movie.productionCompanies.isNotEmpty) ...[
                          SizedBox(height: spacing),
                          Text(
                            'Production Companies',
                            style: AppTextStyle.h4SemiBold.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(height: spacing),
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
                          SizedBox(height: spacing),
                          Text(
                            'Similar Movies',
                            style: AppTextStyle.h4SemiBold.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(height: spacing),
                          MovieList(movies: recommended),
                        ],
                        SizedBox(height: spacing),
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
