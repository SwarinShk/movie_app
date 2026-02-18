import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/utils/validators.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/common/widgets/button/custom_button.dart';
import 'package:movie_app/common/widgets/button/custom_text_button.dart';
import 'package:movie_app/common/widgets/card/labeled_field.dart';
import 'package:movie_app/common/widgets/textfield/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use watch to rebuild when isLoading changes
    final authProvider = context.watch<AuthServiceProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        leading: Icons.chevron_left,
        onLeadingPressed: () => context.pop(),
        title: 'Login',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Welcome Back 👋',
                  style: AppTextStyle.h2SemiBold.copyWith(
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Today is a new trading day. Stay informed, track the market, and manage your investments with confidence.',
                  style: AppTextStyle.h5Medium.copyWith(color: AppColor.white),
                ),
                const SizedBox(height: 50),
                LabeledField(
                  label: 'Username',
                  child: CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Please enter your username',
                    validator: AppValidator.validateUserName,
                  ),
                ),
                const SizedBox(height: 15),
                LabeledField(
                  label: 'Password',
                  child: CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Please enter your password',
                    obscureText: true,
                    validator: AppValidator.validatePassword,
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    title: 'Forgot Password?',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: authProvider.isLoading ? 'Logging In...' : 'Log In',
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          bool success = await authProvider.login(
                            username: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          if (success) {
                            if (context.mounted) {
                              context.go('/home');
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Login failed. Please try again.',
                              backgroundColor: AppColor.redAccent,
                            );
                          }
                        },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
