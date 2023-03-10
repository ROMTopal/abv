import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_style.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final int? maxLines;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final String? prefixIcon;
  final Color? prefixColor;
  final Color? iconClr;
  final bool? obscureText;
  final Widget? suffixWidget;

  const CustomTextField(
      {Key? key,
      this.hint,
      this.maxLines,
      this.controller,
      this.validator,
      this.textInputType,
      this.prefixIcon,
      this.obscureText,
      this.prefixColor,
      this.suffixWidget, this.iconClr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign : TextAlign.start,
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.borderClr),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: IconCard(
            bgColor: prefixColor,
            icon: prefixIcon,
            iconClr: iconClr,
          ),
        ),
        suffixIcon: suffixWidget,
        hintText: hint,
        hintStyle: MyStyles.gray16regular.copyWith(
            color: Theme.of(context).hintColor
        ),
      ),
    );
  }
}
