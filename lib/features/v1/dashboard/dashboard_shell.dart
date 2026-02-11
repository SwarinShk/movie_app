import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class DashboardShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardShell({required this.navigationShell, super.key});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: StylishBottomBar(
        elevation: 0,
        backgroundColor: AppColor.dark,
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizontal,
          bubbleFillStyle: BubbleFillStyle.fill,
          opacity: 0.1,
        ),
        items: [
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: AppColor.redAccent,
            selectedColor: AppColor.redAccent,
            unSelectedColor: AppColor.grey,
          ),
          BottomBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            backgroundColor: AppColor.redAccent,
            selectedColor: AppColor.redAccent,
            unSelectedColor: AppColor.grey,
          ),
          BottomBarItem(
            icon: Icon(Icons.download),
            title: Text('Download'),
            backgroundColor: AppColor.redAccent,
            selectedColor: AppColor.redAccent,
            unSelectedColor: AppColor.grey,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: AppColor.redAccent,
            selectedColor: AppColor.redAccent,
            unSelectedColor: AppColor.grey,
          ),
        ],
      ),
    );
  }
}
