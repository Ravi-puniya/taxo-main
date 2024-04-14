import 'package:flutter/material.dart';
import 'package:facturadorpro/shared/enums.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    required this.label,
    this.position,
  });

  final String label;
  final HeadLinePosition? position;

  @override
  Widget build(BuildContext context) {
    int flexLeft = 1;
    int flexRight = 1;

    if (position == HeadLinePosition.LEFT) {
      flexLeft = 1;
      flexRight = 10;
    }

    if (position == HeadLinePosition.RIGHT) {
      flexLeft = 10;
      flexRight = 1;
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: flexLeft,
          child: new Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: flexRight,
          child: new Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
