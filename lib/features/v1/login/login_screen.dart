import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/shared/appbar/custom_appbar.dart';
import 'package:movie_app/shared/button/custom_button.dart';
import 'package:movie_app/shared/card/labeled_field.dart';
import 'package:movie_app/shared/textfield/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Icons.chevron_left,
        onLeadingPressed: () {
          context.pop();
        },
        title: 'Login',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              SizedBox(height: 30),
              Text(
                'Welcome Back 👋',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 28),
              Text(
                'Today is a new trading day. Stay informed, track the market, and manage your investments with confidence.',
                style: TextStyle(
                  color: AppColor.whiteGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 50),
              LabeledField(
                label: 'Email',
                child: CustomTextFormField(hintText: 'Please enter your email'),
              ),
              SizedBox(height: 15),
              LabeledField(
                label: 'Password',
                child: CustomTextFormField(
                  hintText: 'Please enter your password',
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColor.lineDark,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 14, color: AppColor.redAccent),
                  ),
                ),
              ),
              SizedBox(height: 40),
              CustomButton(
                title: 'Log In',
                onPressed: () {
                  context.go('/home');
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
