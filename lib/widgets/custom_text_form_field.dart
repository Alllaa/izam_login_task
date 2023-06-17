import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izam_task/consts/colors.dart';
import 'package:izam_task/widgets/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType inputType;
  final bool obscureText;
  TextEditingController? controller;
  final bool isHiddenPassword;
  final String obscuringCharacter;
  final String hint;
  final InputDecoration? decoration;
  final Function(String?) onSave;
  final Function()? onTapShowHidePassword;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;

  int maxLines;
  int maxLength;
  Widget? suffixIcon;
  bool enable;
  List<TextInputFormatter>? inputFormater;

  CustomTextFormField(
      {Key? key,
      required this.hint,
      required this.onSave,
      required this.inputType,
      this.validator,
      this.controller,
      this.onChange,
      this.obscureText = false,
      this.decoration,
      this.maxLines = 1,
      this.maxLength = 100,
      this.enable = true,
      this.inputFormater,
      this.isHiddenPassword = false,
      this.obscuringCharacter = " ",
      this.onTapShowHidePassword,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      onSaved: onSave,
      validator: validator,
      cursorColor: const Color(ColorCode.darkGray),
      showCursor: true,
      textAlign: TextAlign.start,
      keyboardType: inputType,
      maxLines: maxLines,
      inputFormatters: inputFormater,
      maxLength: maxLength,
      onChanged: onChange,
      textAlignVertical: TextAlignVertical.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText && isHiddenPassword,
      obscuringCharacter: obscuringCharacter,
      style: TextStyles.textMedium.copyWith(
        color: const Color(ColorCode.black),
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
      ),
      decoration: decoration ??
          InputDecoration(
            hintText: hint,
            counterText: '',
            hintStyle: const TextStyle(
                fontSize: 14, color: Color(ColorCode.lightGray)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: Color(ColorCode.background), width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: Color(ColorCode.background), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: Color(ColorCode.background), width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: Color(ColorCode.background), width: 1),
            ),
            fillColor: Color(ColorCode.background),
            filled: true,
            errorMaxLines: 3,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8).r,
            suffixIcon: obscureText
                ? GestureDetector(
                onTap: onTapShowHidePassword,
                child: isHiddenPassword
                    ? const Icon(
                  Icons.visibility_off,
                  size: 24,
                  color: Color(0xff808080),
                ):const Icon(
                  Icons.visibility,
                  size: 24,
                  color: Color(0xff808080),
                )
              // : AppSVGAssets.getWidget(AppSVGAssets.showPassword)
            )
                : null,
          ),
    );
  }
}
