import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/shared/button/custom_button.dart';
import 'package:movie_app/shared/button/socials_button.dart';
import 'package:movie_app/shared/indicator/line_divider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Enter your registered\nPhone Number to Sign Up',
                      style: TextStyle(
                        color: AppColor.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: .center,
                    ),
                    SizedBox(height: 75),
                    CustomButton(title: 'Sign Up', onPressed: () {}),
                    SizedBox(height: 40),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(text: 'I already have an account?'),
                          TextSpan(text: '  '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: AppColor.redAccent),
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
                          style: TextStyle(
                            color: AppColor.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
