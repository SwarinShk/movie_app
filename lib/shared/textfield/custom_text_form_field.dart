import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefix;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLine;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.prefix,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.maxLine = 1,
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
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured,
      validator: widget.validator,
      maxLines: widget.maxLine,
      decoration: InputDecoration(
        prefixIcon: widget.prefix != null ? Icon(widget.prefix) : null,
        prefixIconColor: AppColor.grey,
        filled: true,
        fillColor: AppColor.soft,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColor.grey, fontSize: 14),
        errorStyle: TextStyle(fontSize: 12, color: AppColor.redAccent),
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
