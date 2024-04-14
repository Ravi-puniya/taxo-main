import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/small_loader.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/widgets/expanded_empty_alert.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';

class MoneyFilter extends GetView<PosController> {
  const MoneyFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TypeAheadFormField(
        hideKeyboard: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller.suggestCoinCnt,
          decoration: InputDecoration(
            labelText: "Moneda",
            hintText: "Seleccione",
            border: InputBorder.none,
            isDense: true,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            contentPadding: EdgeInsets.only(
              left: 12.0,
              top: 8.0,
              bottom: 5.0,
            ),
          ),
        ),
        suggestionsCallback: (query) async {
          return controller.currencyTypes;
        },
        hideOnLoading: true,
        hideSuggestionsOnKeyboardHide: false,
        errorBuilder: (BuildContext _context, error) {
          return ExpandedEmptyAlert();
        },
        noItemsFoundBuilder: (BuildContext _context) {
          return ExpandedEmptyAlert(
            message: 'No se encontraron registros',
            topZero: true,
          );
        },
        loadingBuilder: (_) => SmallLoader(),
        suggestionsBoxVerticalOffset: 1.0,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          elevation: 0,
          shadowColor: Colors.transparent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        itemBuilder: (context, CurrencyType suggestion) {
          return ListTile(
            dense: true,
            title: Text(
              "${suggestion.description} (${suggestion.symbol})",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        onSuggestionSelected: (CurrencyType suggestion) {
          controller.onSelectCoin(coin: suggestion);
        },
      ),
    );
  }
}
