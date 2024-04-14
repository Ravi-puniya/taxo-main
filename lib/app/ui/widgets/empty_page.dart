import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height - 84.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: EmptyIconChild(),
      ),
    );
  }
}

Widget EmptyIconChild() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade100,
          ),
          child: Icon(
            Icons.inbox,
            color: Colors.grey.shade500,
            size: 32.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Sin registros',
          style: TextStyle(color: Colors.grey.shade500),
        )
      ],
    ),
  );
}
