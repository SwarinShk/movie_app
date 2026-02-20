import 'package:flutter/material.dart';

class HorizontalItem extends StatelessWidget {
  final double height;
  final double avatarRadius;
  final double spacing;
  final String name;
  final String description;
  final ImageProvider<Object>? backgroundImage;

  const HorizontalItem({
    super.key,
    this.height = 60,
    this.avatarRadius = 30,
    this.spacing = 12,
    required this.name,
    required this.description,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Colors.white,
          backgroundImage: backgroundImage,
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              description,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
