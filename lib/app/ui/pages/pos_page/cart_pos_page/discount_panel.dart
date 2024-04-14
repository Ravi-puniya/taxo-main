import 'package:flutter/material.dart';

class DiscountPanel extends StatelessWidget {
  const DiscountPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Los descuentos se encuentran en mantenimiento",
          ),
        ),
      ],
    );
  }
}
