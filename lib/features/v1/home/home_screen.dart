import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/v1/home/widget/movie_area.dart';
import 'package:movie_app/features/v1/home/widget/movie_horizontal_list.dart';
import 'package:movie_app/features/v1/home/widget/movie_swiper.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/shared/appbar/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieProvider movieProvider;

  void init() {
    Future.microtask(() {
      if (mounted) {
        movieProvider = context.read<MovieProvider>();
      }
      movieProvider.fetchMovies(MovieCategory.nowPlaying);
      movieProvider.fetchMovies(MovieCategory.popular);
      movieProvider.fetchMovies(MovieCategory.topRated);
      movieProvider.fetchMovies(MovieCategory.upcoming);
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: HomeAppBar(
        userName: authProvider.account?.username ?? 'Guest',
        subtitle: "Let's stream your favorite movie",
        onFavoriteTap: () {
          authProvider.logout();
          context.goNamed('signup');
        },
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
                onPressed: () {},
                child: MovieSwiper(category: MovieCategory.upcoming),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Now Playing',
                onPressed: () {},
                child: MovieHorizontalList(category: MovieCategory.nowPlaying),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Top Rated Movies',
                onPressed: () {},
                child: MovieHorizontalList(category: MovieCategory.topRated),
              ),
              const SizedBox(height: 20),
              MovieArea(
                title: 'Popular Movies',
                onPressed: () {},
                child: MovieHorizontalList(category: MovieCategory.popular),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
