import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_list.dart';
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

        return TvList(
          onTvItemTap: (tv) {
            context.push('/tvdetail/${tv.id}');
          },
          tvs: tvs,
        );
      },
    );
  }
}
