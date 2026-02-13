import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/core/constants/storage_constants.dart';
import 'package:movie_app/shared/indicator/dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'The biggest international and local film streaming',
      'subtitle':
          'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.',
    },
    {
      'title': 'Offers ad-free viewing of high quality',
      'subtitle':
          'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.',
    },
    {
      'title': 'Our service brings together your favorite series',
      'subtitle':
          'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.',
    },
  ];

  void _nextPage() async {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool(StorageConstants.firstTime, false);

      if (!mounted) return;
      context.pushReplacementNamed('signup');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding_backgroung.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 160,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _pages.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                _pages[index]['title']!,
                                style: AppTextStyle.h3SemiBold.copyWith(
                                  color: AppColor.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _pages[index]['subtitle']!,
                                style: AppTextStyle.h5Medium.copyWith(
                                  color: AppColor.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotsIndicator(
                          currentIndex: _currentPage,
                          totalDots: _pages.length,
                        ),
                        IconButton.filled(
                          onPressed: _nextPage,
                          icon: const Icon(Icons.chevron_right),
                          constraints: const BoxConstraints(
                            minHeight: 60,
                            minWidth: 60,
                          ),
                          style: IconButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColor.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
