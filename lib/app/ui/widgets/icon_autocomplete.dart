import 'package:flutter/material.dart';

class IconAutoComplete extends StatelessWidget {
  const IconAutoComplete({
    Key? key,
    required this.isEmpty,
    this.icon,
  }) : super(key: key);

  final bool isEmpty;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      this.isEmpty == true
          ? icon != null
              ? icon
              : Icons.search_rounded
          : Icons.close,
      size: 16.0,
    );
  }
}
