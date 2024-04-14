import 'package:flutter/material.dart';

class EmptyChoices extends StatelessWidget {
  const EmptyChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.search,
              color: Colors.grey,
              size: 120.0,
            ),
            const SizedBox(height: 25),
            const Text(
              'Vaya, no hay coincidencias',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 7),
            const Text(
              "No pudimos encontrar ningún resultado.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 7),
            const Text(
              "Dale otra oportunidad",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
