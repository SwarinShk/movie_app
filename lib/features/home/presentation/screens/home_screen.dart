import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_area.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_horizontal_list.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_swiper.dart';
import 'package:movie_app/features/home/presentation/widgets/tv_horizontal_list.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/common/widgets/appbar/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieProvider movieProvider;
  late TvProvider tvProvider;

  void init() {
    Future.microtask(() {
      if (mounted) {
        movieProvider = context.read<MovieProvider>();
        tvProvider = context.read<TvProvider>();
      }
      movieProvider.fetchMovies(MovieCategory.nowPlaying);
      movieProvider.fetchMovies(MovieCategory.popular);
      movieProvider.fetchMovies(MovieCategory.topRated);
      movieProvider.fetchMovies(MovieCategory.upcoming);

      tvProvider.fetchTv(TvCategory.onTheAir);
      tvProvider.fetchTv(TvCategory.popular);
      tvProvider.fetchTv(TvCategory.topRated);
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthServiceProvider>();

    return Scaffold(
      appBar: HomeAppBar(
        userName: authProvider.account?.username ?? 'Guest',
        subtitle: "Let's stream your favorite movie",
        avatar: authProvider.account?.avatar,
        onFavoriteTap: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const SizedBox(height: 20),
              MovieArea(
                title: 'Upcoming Movies',
                onPressed: () {
                  context.push('/movielist/${MovieCategory.upcoming.name}');
                },
                child: MovieSwiper(category: MovieCategory.upcoming),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Now Playing Movies',
                onPressed: () {
                  context.push('/movielist/${MovieCategory.nowPlaying.name}');
                },
                child: MovieHorizontalList(category: MovieCategory.nowPlaying),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'On The Air TV Shows',
                onPressed: () {
                  // context.push('/movielist/${MovieCategory.nowPlaying.name}');
                },
                child: TvHorizontalList(category: TvCategory.onTheAir),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Top Rated Movies',
                onPressed: () {
                  context.push('/movielist/${MovieCategory.topRated.name}');
                },
                child: MovieHorizontalList(category: MovieCategory.topRated),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Top Rated TV Shows',
                onPressed: () {
                  // context.push('/movielist/${MovieCategory.nowPlaying.name}');
                },
                child: TvHorizontalList(category: TvCategory.topRated),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Popular Movies',
                onPressed: () {
                  context.push('/movielist/${MovieCategory.popular.name}');
                },
                child: MovieHorizontalList(category: MovieCategory.popular),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Popular TV Shows',
                onPressed: () {
                  // context.push('/movielist/${MovieCategory.nowPlaying.name}');
                },
                child: TvHorizontalList(category: TvCategory.popular),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
