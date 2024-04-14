import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/alert.dart';

class ExpandedEmptyAlert extends StatelessWidget {
  const ExpandedEmptyAlert({
    Key? key,
    this.message,
    this.topZero,
  }) : super(key: key);

  final String? message;
  final bool? topZero;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          this.topZero == true ? EdgeInsets.zero : EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: alertBgWarnColor.withOpacity(0.30),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle_notifications,
            color: alertTextWarnColor,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            this.message ?? '¡Ups! No se encontraron registros.',
            style: TextStyle(color: alertTextWarnColor),
          ),
        ],
      ),
    );
  }
}
