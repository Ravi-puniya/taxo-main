import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class CustomSelectForm extends StatelessWidget {
  const CustomSelectForm({
    Key? key,
    required this.title,
    required this.items,
    this.onChanged,
    this.enabled,
    this.type,
    this.dialogTitle,
    this.controller,
    this.initialValue,
    this.isDense,
  }) : super(key: key);

  final String title;
  final List<Map<String, dynamic>> items;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final SelectFormFieldType? type;
  final String? dialogTitle;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? isDense;

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      type: type ?? SelectFormFieldType.dropdown,
      initialValue: initialValue,
      dialogTitle: dialogTitle,
      dialogCancelBtn: "Cerrar",
      dialogSearchHint: "Buscar...",
      enableSearch: true,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: title,
        isDense: isDense ?? true,
        suffixIcon: Icon(Icons.arrow_drop_down),
      ),
      enabled: enabled ?? true,
      // ignore: invalid_use_of_protected_member
      items: items,
      onChanged: onChanged,
    );
  }
}
