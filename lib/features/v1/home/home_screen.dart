import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.dark,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircleAvatar(radius: 20, child: Text('SS')),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello, Smith',
              style: TextStyle(color: AppColor.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Let\'s stream your favorite movie',
              style: TextStyle(color: AppColor.whiteGrey, fontSize: 13),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              style: IconButton.styleFrom(
                backgroundColor: AppColor.soft,
                foregroundColor: AppColor.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            children: const [
              SizedBox(height: 20),
              Text(
                "Trending Now",
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    "Movie List Here",
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
