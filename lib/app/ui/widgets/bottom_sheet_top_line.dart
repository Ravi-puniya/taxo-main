import 'package:flutter/material.dart';

class BottomSeetTopLine extends StatelessWidget {
  const BottomSeetTopLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5.0,
        width: MediaQuery.of(context).size.width * 0.2,
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.20),
        ),
      ),
    );
  }
}
