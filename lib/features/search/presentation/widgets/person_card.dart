import 'package:flutter/material.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';

class PersonCard extends StatelessWidget {
  final SearchResult item;

  const PersonCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: item.profilePath != null
              ? NetworkImage(
                  'https://image.tmdb.org/t/p/w300${item.profilePath}',
                )
              : AssetImage('assets/images/image_not_found.png'),
          backgroundColor: Colors.grey.shade800,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              item.displayTitle,
              style: AppTextStyle.h4Medium.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              item.knownForDepartment.toString(),
              style: AppTextStyle.h5Medium.copyWith(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
