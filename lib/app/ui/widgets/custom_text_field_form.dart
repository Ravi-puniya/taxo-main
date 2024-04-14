import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({
    Key? key,
    this.controller,
    this.inputType,
    required this.label,
    this.isDense,
    this.formatters,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.focusNode,
    this.textAlign,
    this.labelDirection,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? inputType;
  final String label;
  final bool? isDense;
  final List<TextInputFormatter>? formatters;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final TextDirection? labelDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: labelDirection ?? TextDirection.ltr,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          floatingLabelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
          isDense: isDense ?? true,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffix,
        ),
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.left,
        inputFormatters: formatters ?? [],
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        cursorColor: primaryColor,
        onChanged: onChanged,
        keyboardType: inputType ?? TextInputType.text,
      ),
    );
  }
}
