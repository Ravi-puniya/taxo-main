import 'package:flutter/material.dart';

class TextFieldErrors extends StatelessWidget {
  const TextFieldErrors({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Column(
          children: errors.map((error) {
            return Row(
              children: [
                Icon(
                  Icons.warning,
                  size: 12.0,
                  color: Colors.red.shade500,
                ),
                SizedBox(width: 4.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red.shade500,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
