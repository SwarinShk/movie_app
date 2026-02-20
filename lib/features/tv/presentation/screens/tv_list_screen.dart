import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_list_item.dart';
import 'package:provider/provider.dart';

class TvListScreen extends StatefulWidget {
  final TvCategory category;

  const TvListScreen({required this.category, super.key});

  @override
  State<TvListScreen> createState() => _TvListScreenState();
}

class _TvListScreenState extends State<TvListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TvProvider>();

      // Fetch only if data is null
      if (provider.tvs(widget.category) == null) {
        provider.fetchTv(widget.category);
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<TvProvider>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.fetchNextPage(widget.category);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvProvider>(
      builder: (context, provider, _) {
        final data = provider.tvs(widget.category);
        final tvs = data?.results ?? [];
        final isLoading = provider.isLoading(widget.category);
        final isFetchingMore = provider.isFetchingMore(widget.category);
        final error = provider.error(widget.category);

        return Scaffold(
          appBar: CustomAppBar(
            leading: Icons.chevron_left,
            onLeadingPressed: () => context.pop(),
            title: widget.category.title,
          ),
          body: SafeArea(
            child: Builder(
              builder: (_) {
                if (isLoading && tvs.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.white),
                  );
                }

                // Error State
                if (error != null && tvs.isEmpty) {
                  return Center(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  itemCount: tvs.length + (isFetchingMore ? 1 : 0),
                  separatorBuilder: (_, _) => SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    // Bottom Loader
                    if (index >= tvs.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
                        ),
                      );
                    }

                    final tv = tvs[index];
                    return TvListItem(tv: tv);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
