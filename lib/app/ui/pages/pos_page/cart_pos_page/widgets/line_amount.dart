import 'package:flutter/material.dart';

class LineAmount extends StatelessWidget {
  const LineAmount({
    Key? key,
    required this.label,
    required this.amount,
    required this.symbolCoin,
    this.spaceTop,
    required this.spaceBottom,
    this.isBold,
    this.textColor,
  }) : super(key: key);

  final String label;
  final String amount;
  final String symbolCoin;
  final double? spaceTop;
  final double spaceBottom;
  final bool? isBold;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    bool bold = isBold != null ? isBold! : false;
    return Container(
      margin: EdgeInsets.only(bottom: spaceBottom, top: spaceTop ?? 0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontFamily: "Kdam",
              color: textColor ?? null,
            ),
          ),
        ],
      ),
    );
  }
}
