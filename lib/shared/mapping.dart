import 'package:facturadorpro/app/ui/models/default_price_model.dart';
import 'package:facturadorpro/app/ui/models/filter_column_model.dart';
import 'package:facturadorpro/app/ui/models/sale_note_column_model.dart';
import 'package:facturadorpro/app/ui/models/voucher_states_model.dart';
import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/models/voucher_types_model.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

List<String> useIgvCodes = [
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "40",
];

List<String> unaffectedCodes = [
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
];

List<String> exoneratedCodes = [
  "20",
  "21",
];

List<VoucherTypesModel> vouchersLetter = [
  VoucherTypesModel(
    voucherId: "01",
    textColor: Colors.green.shade500,
    borderColor: Colors.green.shade100,
    backgroundColor: Colors.green.shade50,
  ),
  VoucherTypesModel(
    voucherId: "03",
    textColor: Colors.blue.shade500,
    borderColor: Colors.blue.shade100,
    backgroundColor: Colors.blue.shade50,
  ),
  VoucherTypesModel(
    voucherId: "80",
    textColor: Colors.purple.shade500,
    borderColor: Colors.purple.shade100,
    backgroundColor: Colors.purple.shade50,
  ),
];

List<VoucherStatesModel> voucherStates = [
  VoucherStatesModel(
    stateId: "01",
    textColor: Colors.grey.shade600,
    borderColor: Colors.grey.shade200,
    backgroundColor: Colors.grey.shade100,
  ),
  VoucherStatesModel(
    stateId: "03",
    textColor: Colors.blue.shade500,
    borderColor: Colors.blue.shade100,
    backgroundColor: Colors.blue.shade50,
  ),
  VoucherStatesModel(
    stateId: "05",
    textColor: Colors.green.shade500,
    borderColor: Colors.green.shade100,
    backgroundColor: Colors.green.shade50,
  ),
  VoucherStatesModel(
    stateId: "07",
    textColor: Colors.purple.shade500,
    borderColor: Colors.purple.shade100,
    backgroundColor: Colors.purple.shade50,
  ),
  VoucherStatesModel(
    stateId: "09",
    textColor: Colors.red.shade500,
    borderColor: Colors.red.shade100,
    backgroundColor: Colors.red.shade50,
  ),
  VoucherStatesModel(
    stateId: "11",
    textColor: Colors.red.shade500,
    borderColor: Colors.red.shade100,
    backgroundColor: Colors.red.shade50,
  ),
  VoucherStatesModel(
    stateId: "13",
    textColor: Colors.orange.shade500,
    borderColor: Colors.orange.shade100,
    backgroundColor: Colors.orange.shade50,
  ),
  VoucherStatesModel(
    stateId: "P",
    textColor: Colors.green.shade500,
    borderColor: Colors.green.shade100,
    backgroundColor: Colors.green.shade50,
  ),
];

List<S2Choice<SaleNoteColumnModel>> columnsFilterSaleNote = [
  S2Choice(
    value: SaleNoteColumnModel(
      id: "date_of_issue",
      description: "Fecha de emisión",
    ),
    title: "Fecha de emisión",
  ),
  S2Choice(
    value: SaleNoteColumnModel(
      id: "customer",
      description: "Cliente",
    ),
    title: "Cliente",
  ),
];

List<S2Choice<SaleNoteColumnModel>> statusPaidSaleNote = [
  S2Choice(
    value: SaleNoteColumnModel(
      id: "0",
      description: "Pendiente",
    ),
    title: "Pendiente",
  ),
  S2Choice(
    value: SaleNoteColumnModel(
      id: "1",
      description: "Pagado",
    ),
    title: "Pagado",
  ),
];

List<S2Choice<DefaultPriceModel>> defaultPriceChoices = [
  S2Choice(
    value: DefaultPriceModel(
      id: 1,
      description: "Precio 1",
    ),
    title: "Precio 1",
  ),
  S2Choice(
    value: DefaultPriceModel(
      id: 2,
      description: "Precio 2",
    ),
    title: "Precio 2",
  ),
  S2Choice(
    value: DefaultPriceModel(
      id: 3,
      description: "Precio 3",
    ),
    title: "Precio 3",
  ),
];

List<S2Choice<FilterColumnModel>> clientColumns = [
  S2Choice(
    value: FilterColumnModel(
      id: "name",
      description: "Nombre",
    ),
    title: "Nombre",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "number",
      description: "Número",
    ),
    title: "Número",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "barcode",
      description: "Código de barras",
    ),
    title: "Código de barras",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "document_type",
      description: "Tipo de documento",
    ),
    title: "Tipo de documento",
  ),
];

List<S2Choice<FilterColumnModel>> productColumns = [
  S2Choice(
    value: FilterColumnModel(
      id: "description",
      description: "Nombre",
    ),
    title: "Nombre",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "internal_id",
      description: "Código interno",
    ),
    title: "Código interno",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "barcode",
      description: "Código de barras",
    ),
    title: "Código de barras",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "model",
      description: "Modelo",
    ),
    title: "Model",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "brand",
      description: "Marca",
    ),
    title: "Marca",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "date_of_due",
      description: "Fecha vencimiento",
    ),
    title: "Fecha vencimiento",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "lot_code",
      description: "Código lote",
    ),
    title: "Código lote",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "active",
      description: "Habilitados",
    ),
    title: "Habilitados",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "inactive",
      description: "Inhabilitados",
    ),
    title: "Inhabilitados",
  ),
  S2Choice(
    value: FilterColumnModel(
      id: "category",
      description: "Categoria",
    ),
    title: "Categoria",
  ),
];

List<S2Choice<FilterColumnModel>> cashBoxColumns = [
  S2Choice(
    value: FilterColumnModel(
      id: "income",
      description: "Ingresos",
    ),
    title: "Ingresos",
  ),
];
