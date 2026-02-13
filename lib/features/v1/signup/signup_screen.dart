import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/shared/button/custom_button.dart';
import 'package:movie_app/shared/button/socials_button.dart';
import 'package:movie_app/shared/indicator/line_divider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void _launchURLBrowser() async {
    var url = Uri.parse("https://www.themoviedb.org/signup/");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    SizedBox(height: 15),
                    Image.asset(
                      'assets/logos/app_logo.png',
                      width: 90,
                      height: 90,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'ClipIt',
                      style: AppTextStyle.h1SemiBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Enter your registered\nPhone Number to Sign Up',
                      style: AppTextStyle.h5SemiBold.copyWith(
                        color: AppColor.grey,
                      ),
                      textAlign: .center,
                    ),
                    SizedBox(height: 75),
                    CustomButton(
                      title: 'Sign Up',
                      onPressed: _launchURLBrowser,
                    ),
                    SizedBox(height: 40),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.h4Medium.copyWith(
                          color: AppColor.grey,
                        ),
                        children: [
                          TextSpan(text: 'I already have an account?'),
                          TextSpan(text: '  '),
                          TextSpan(
                            text: 'Login',
                            style: AppTextStyle.h4Medium.copyWith(
                              color: AppColor.redAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.pushNamed('login'),
                          ),
                        ],
                      ),
                      textAlign: .center,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 25),
                        LineDivider(),
                        SizedBox(width: 15),
                        Text(
                          'Or Sign up with',
                          style: AppTextStyle.h5Medium.copyWith(
                            color: AppColor.grey,
                          ),
                          textAlign: .center,
                        ),
                        SizedBox(width: 15),
                        LineDivider(),
                        SizedBox(width: 25),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      spacing: 30,
                      mainAxisAlignment: .center,
                      children: [
                        SocialsButton(
                          icon: 'assets/icons/google_icon.png',
                          backgroundColor: AppColor.google,
                          onPressed: () {},
                        ),
                        SocialsButton(
                          icon: 'assets/icons/apple_icon.png',
                          backgroundColor: AppColor.apple,
                          onPressed: () {},
                        ),
                        SocialsButton(
                          icon: 'assets/icons/facebook_icon.png',
                          backgroundColor: AppColor.facebook,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
