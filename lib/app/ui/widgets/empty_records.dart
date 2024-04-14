import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EmptyRecords extends StatelessWidget {
  const EmptyRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        color: Colors.grey.shade300,
        dashPattern: [4, 4],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 40.0,
                ),
                const SizedBox(height: 16),
                const Text(
                  "No se encontraron registros.",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
