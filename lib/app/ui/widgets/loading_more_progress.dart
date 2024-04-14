import 'package:flutter/material.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';

class LoadingMoreProgress extends StatelessWidget {
  const LoadingMoreProgress({
    Key? key,
    this.label,
  }) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      color: Colors.transparent,
      width: double.infinity,
      child: Center(
        child: label != null
            ? SizedBox(
                height: 30.0,
                child: Text(label!),
              )
            : SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(color: primaryColor),
              ),
      ),
    );
  }
}
