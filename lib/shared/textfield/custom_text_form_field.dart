import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefix;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.prefix,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured,
      validator: widget.validator,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      style: AppTextStyle.h5Regular.copyWith(color: AppColor.white),
      decoration: InputDecoration(
        prefixIcon: widget.prefix != null ? Icon(widget.prefix) : null,
        prefixIconColor: AppColor.grey,
        filled: true,
        fillColor: AppColor.soft,
        hintText: widget.hintText,
        hintStyle: AppTextStyle.h5Regular.copyWith(color: AppColor.grey),
        errorStyle: AppTextStyle.h6Regular.copyWith(color: AppColor.redAccent),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(color: AppColor.grey),
        errorBorder: _border(color: AppColor.redAccent),
        focusedErrorBorder: _border(color: AppColor.redAccent),
        suffixIcon: widget.obscureText ? _buildVisibilityIcon() : null,
      ),
    );
  }

  Widget _buildVisibilityIcon() {
    return IconButton(
      icon: Icon(
        _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColor.grey,
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }

  OutlineInputBorder _border({Color color = AppColor.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: color),
    );
  }
}
