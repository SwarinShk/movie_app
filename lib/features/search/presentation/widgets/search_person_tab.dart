import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/search/data/models/person_model.dart';
import 'package:movie_app/features/search/presentation/widgets/empty_search_state.dart';

class SearchPeopleTab extends StatelessWidget {
  final String query;
  final List<PersonResult> items;
  final bool isLoading;
  final bool isFetchingMore;
  final ScrollController scrollController;

  const SearchPeopleTab({
    super.key,
    required this.query,
    required this.items,
    required this.isLoading,
    required this.isFetchingMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.white),
      );
    } else if (items.isEmpty) {
      return const EmptySearchState();
    }

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: items.length + (isFetchingMore ? 1 : 0),
      separatorBuilder: (_, _) => SizedBox(height: 15),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(color: AppColor.white),
            ),
          );
        }

        final person = items[index];
        return Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: person.profilePath != null
                  ? NetworkImage(
                      'https://image.tmdb.org/t/p/w92${person.profilePath}',
                    )
                  : AssetImage('assets/images/image_not_found.png'),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  person.name,
                  style: const TextStyle(color: AppColor.white),
                ),
                SizedBox(height: 4),
                Text(
                  person.knownForDepartment,
                  style: const TextStyle(color: AppColor.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
