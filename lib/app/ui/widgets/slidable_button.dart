import 'package:flutter/material.dart';

class SlidableButton extends StatelessWidget {
  const SlidableButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.text,
    this.bgColor,
    this.textColor,
    this.marginRight,
    this.width,
    this.height,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final String? text;
  final Color? bgColor;
  final Color? textColor;
  final double? marginRight;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 90.0,
        height: height ?? 90.0,
        margin: EdgeInsets.only(right: marginRight ?? 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: bgColor ?? Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: textColor ?? Colors.black,
            ),
            if (text != null) SizedBox(height: 6.0),
            if (text != null)
              Text(
                text!,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
