import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';

ExpansionPanel CustomExpandedPanel({
  required int index,
  required String title,
  Widget? subtitle,
  required bool isExpanded,
  required Widget bodyWidget,
  required BuildContext context,
}) {
  return ExpansionPanel(
    headerBuilder: (context, isExpanded) => ListTile(
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle,
    ),
    body: bodyWidget,
    isExpanded: isExpanded,
    canTapOnHeader: true,
    backgroundColor: Colors.white,
  );
}
