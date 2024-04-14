import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';

class SmallLoader extends StatelessWidget {
  const SmallLoader({
    Key? key,
    this.size,
    this.strokeWidth,
    this.color,
  }) : super(key: key);

  final double? size;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size ?? 40.0,
        height: size ?? 40.0,
        child: CircularProgressIndicator(
          color: color ?? primaryColor,
          strokeWidth: strokeWidth ?? 2,
        ),
      ),
    );
  }
}
