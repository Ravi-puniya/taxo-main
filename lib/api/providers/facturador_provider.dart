import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/constants.dart';
import 'package:facturadorpro/app/ui/models/product_param_model.dart';
import 'package:facturadorpro/api/models/voucher_response_model.dart';
import 'package:facturadorpro/api/models/request/filter_voucher_req.dart';
import 'package:facturadorpro/api/models/request/voucher_request_model.dart';
import 'package:facturadorpro/api/models/request/filter_sale_note_req.dart';
import 'package:facturadorpro/api/models/request/client_request_model.dart';

class FacturadorProvider extends GetConnect {
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = "${storage.read('domain')}/api/app"; // Aquí se establece la URL base
    httpClient.addRequestModifier<void>((request) {
      request.headers['Authorization'] = 'Bearer ${storage.read('token')}';
      request.headers['Content-Type'] = 'application/json; charset=utf-8';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      if ([500, 400, 405].contains(response.statusCode)) {
        displayErrorMessage();
      }
      if (response.statusCode == 404) {
        displayErrorMessage(message: "La ruta no fue encontrada");
      }
      return response;
    });
    super.onInit();
  }

  // ** CAJA CHICA **
  Future<Response> filterCashBoxes({
    required int page,
    String column = "income",
    String value = "",
  }) async {
    String link = "/cash/records";
    Map<String, String> query = {
      "column": column,
      "page": page.toString(),
      "value": value,
    };
    return await get(link, query: query);
  }

  Future<Response> registerCashBox({
    required double initialBalance,
    required int sellerId,
    String? referenceCode,
  }) async {
    Map<String, dynamic> body = {
      "user_id": sellerId,
      "beginning_balance": initialBalance,
      "final_balance": 0,
      "income": 0,
      "state": true,
    };
    if (referenceCode != null) {
      body.addAll({"reference_number": referenceCode});
    }
    return await post("/cash", body);
  }

  Future<Response> updateCashBox({
    required int cashId,
    required double initialBalance,
    required int sellerId,
    String? referenceCode,
  }) async {
    Map<String, dynamic> body = {
      "id": cashId,
      "user_id": sellerId,
      "beginning_balance": initialBalance,
      "reference_number": referenceCode ?? null,
    };
    return await post("/cash", body);
  }

  Future<Response> registerSaleInCashBox({
    int? documentId,
    int? saleNoteId,
  }) async {
    Map<String, int?> body = {
      "document_id": documentId,
      "sale_note_id": saleNoteId,
    };
    return await post("/cash/cash_document", body);
  }

  Future<Response> deleteCashBox({required int id}) async {
    return await delete("/cash/$id");
  }

  Future<Response> closeCashBox({required int id}) async {
    return await get("/cash/close/$id");
  }

  Future<Response> initParamsCashBox() async {
    return await get("/cash/tables");
  }

  Future<Response> checkCashByUser({required int id}) async {
    return await get("/cash/opening_cash_check/$id");
  }

  Future<Response> retrieveCashInfo({required int id}) async {
    return await get("/cash/record/$id");
  }

  // ** CONFIGURACIÓN **
  Future<Response> retrieveConfigParams() async {
    return await get("/configurations/record");
  }

  // ** SUNAT **

  Future<Response> fetchSunatPerson({
    required String action,
    required String number,
  }) async {
    return await get("/service/$action/$number");
  }


  Future<Response> fetchSunatExchange({required String date}) async {
    return await get("/service/exchange/$date");
  }

  // ** CLIENTES **
  Future<Response> filterClients({
    required int page,
    String column = "name",
    String value = "",
  }) async {
    String link = "/persons/customers/records";
    Map<String, String> query = {
      "column": column,
      "page": page.toString(),
      "value": value,
    };
    return await get(link, query: query);
  }

  Future<Response> initParamsClient() async {
    return await get("/persons/tables");
  }

  Future<Response> registerClient(ClientRequestModel client) async {
    Map<String, dynamic> body = {
      "type": "customers",
      "credit_days": client.creditDays,
      "identity_document_type_id": client.identityDocumentTypeId,
      "number": client.number,
      "name": client.name,
      "trade_name": client.tradeName,
      "country_id": "PE",
      "department_id": client.departmentId,
      "province_id": client.provinceId,
      "district_id": client.districtId,
      "address": client.address,
      "telephone": client.telephone,
      "condition": client.condition,
      "state": client.state,
      "email": client.email,
      "perception_agent": false,
      "percentage_perception": 0,
      "person_type_id": client.personTypeId,
      "comment": client.comment,
      "addresses": [],
      "contact": {
        "full_name": client.contact.fullName,
        "phone": client.contact.phone,
      },
      "optional_email": [],
      "location_id": [null, null, null],
      "internal_code": client.internalCode,
      "barcode": client.barcode,
      "website": client.website,
      "observation": client.observation,
      "seller_id": client.sellerId,
      "parent_id": 0,
    };
    if (client.id != null) {
      body["id"] = client.id;
    }
    return await post("/persons", body);
  }

  Future<Response> retrieveClient({required int id}) async {
    return await get("/persons/record/$id");
  }

  Future<Response> deleteClient({required int id}) async {
    return await delete("/persons/$id");
  }

  // ** VOUCHERS **
  Future<Response> sendEmailToClient({
    required String email,
    required int documentId,
  }) async {
    Map<String, dynamic> body = {
      "customer_email": email,
      "id": documentId,
    };
    return await post("/documents/email", body);
  }

  Future<Response> fetchFilterParamsVouchers() async {
    return await get("/documents/data_table");
  }

  Future<Response> fetchFilterParamsSaleNotes() async {
    return await get("/sale-notes/columns2");
  }

  Future<Response> fetchPrintVoucherInfo({required int documentId}) async {
    return await get("/documents/record/$documentId");
  }

  Future<Response> fetchPrintSaleNoteInfo({required int documentId}) async {
    return await get("/sale-notes/record/$documentId");
  }

  Future<Response> fetchVouchersEndpoint({
    required FilterVoucherReq info,
  }) async {
    Map<String, dynamic> query = {
      "page": info.page.toString(),
      "category_id": info.categoryId ?? "",
      "customer_id": info.customerId ?? "",
      "d_start": info.startDate ?? "",
      "d_end": info.endingDate ?? "",
      "date_of_issue": info.dateOfIssue ?? "",
      "document_type_id": info.documentTypeId ?? "",
      "item_id": info.itemId ?? "",
      "number": info.number ?? "",
      "pending_payment": info.pendingPayment ?? "",
      "series": info.series ?? "",
      "state_type_id": info.stateTypeId ?? "",
    };
    return await get("/documents/records", query: query);
  }

  Future<Response> fetchSaleNotesEndpoint({
    required FilterSaleNoteReq info,
  }) async {
    Map<String, String> query = {
      "page": info.page.toString(),
      "column": info.column ?? "",
      "series": info.series ?? "",
      "number": info.number ?? "",
      "total_canceled":
          info.totalCanceled != null ? info.totalCanceled.toString() : "",
      "value": info.value ?? "",
    };
    return await get("/sale-notes/records", query: query);
  }

  Future<Response> nullifySaleNoteEndpoint({required int id}) async {
    return await get("/sale-notes/anulate/$id");
  }

  Future<Response> saveNullifyEndpoint({
    required Voucher voucher,
    required String motive,
  }) async {
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    Map<String, dynamic> body = {
      "date_of_reference": today,
      "summary_status_type_id": "3",
      "sales_note": [],
      "documents": [
        {
          "document_id": voucher.id,
          "description": motive,
        }
      ]
    };
    String event = "voided";
    if (voucher.documentTypeId == BOLETA) {
      event = "summaries";
    }
    return await post("/$event", body);
  }

  // ** POS **
  Future<Response> initParamsPos() async {
    return await get("/pos/tables");
  }

  Future<Response> initPaymentsPos() async {
    return await get("/pos/payment_tables");
  }

  Future<Response> filterPosItems({
    required int page,
    required int categoryId,
    String searchValue = "",
    String column = "",
  }) async {
    String link = "/pos/search_items_cat";
    Map<String, String> query = {
      "page": page.toString(),
      "input_item": searchValue,
      "cat": categoryId == 0 ? "" : categoryId.toString(),
      "column": column,
    };
    return await get(link, query: query);
  }

  Future<Response> filterPosItemsByBarcode({
    required String barcode,
    bool barcodePresentation = false,
  }) async {
    String link = "/pos/search_items";
    Map<String, String> query = {
      "input_item": barcode,
      "search_item_by_barcode_presentation": barcodePresentation.toString(),
    };
    return await get(link, query: query);
  }

  // ** PRODUCT **
  Future<Response> filterProducts({
    required int page,
    String column = "description",
    String value = "",
  }) async {
    String link = "/paginate-items";
    Map<String, String> query = {
      "column": column,
      "page": page.toString(),
      "type": "PRODUCTS",
      "value": value,
    };
    return await get(link, query: query);
  }

  Future<Response> initParamsProduct() async {
    return await get("/items/tables");
  }

  Future<Response> saveProduct({required ProductParamModel item}) async {
    Map<String, dynamic> body = {
      "id": item.id,
      "colors": [],
      "item_type_id": "01",
      "internal_id": item.internalId,
      "item_code": null,
      "item_code_gs1": null,
      "description": item.name,
      "name": item.name,
      "second_name": null,
      "unit_type_id": item.unitTypeId,
      "currency_type_id": item.currencyTypeId,
      "sale_unit_price": item.saleUnitPrice,
      "purchase_unit_price": item.purchaseUnitPrice,
      "has_isc": false,
      "system_isc_type_id": null,
      "percentage_isc": 0,
      "suggested_price": 0,
      "sale_affectation_igv_type_id": item.saleAffectationIgvTypeId,
      "purchase_affectation_igv_type_id": item.purchaseAffectationIgvTypeId,
      "calculate_quantity": item.calculateQuantity,
      "stock": item.stock,
      "stock_min": item.stockMin,
      "has_igv": item.hasIgv,
      "has_perception": false,
      "item_unit_types": item.itemUnitTypes.map((e) {
        return {
          "id": e.id,
          "description": e.description,
          "unit_type_id": e.unitTypeId,
          "quantity_unit": e.quantityUnit,
          "price1": e.price1,
          "price2": e.price2,
          "price3": e.price3,
          "price_default": e.priceDefault,
          "barcode": e.barcode,
        };
      }).toList(),
      "percentage_of_profit": 0,
      "percentage_perception": null,
      "image": null,
      "image_url": null,
      "temp_path": null,
      "is_set": false,
      "account_id": null,
      "category_id": item.categoryId,
      "brand_id": item.brandId,
      "date_of_due": item.dateOfDue,
      "lot_code": null,
      "line": null,
      "lots_enabled": false,
      "lots": [],
      "attributes": [],
      "series_enabled": false,
      "purchase_has_igv": item.purchaseHasIgv,
      "web_platform_id": null,
      "has_plastic_bag_taxes": false,
      "item_warehouse_prices": item.itemWarehousePrices.map((e) {
        return {
          "id": e.id,
          "item_id": e.itemId,
          "warehouse_id": e.warehouseId,
          "price": e.price,
          "description": e.description
        };
      }).toList(),
      "item_supplies": [],
      "purchase_has_isc": false,
      "purchase_system_isc_type_id": null,
      "purchase_percentage_isc": 0,
      "subject_to_detraction": false,
      "model": item.model,
      "warehouse_id": item.warehouseId,
      "barcode": item.barcode,
    };
    return await post("/items", body);
  }

  Future<Response> retrieveProduct({required int id}) async {
    return await get("/retrieve-item/$id");
  }

  Future<Response> deleteProduct({required int id}) async {
    return await delete("/items/$id");
  }

  Future<Response> deleteUnitTypeOfProduct({required int id}) async {
    return await delete("/items/item-unit-type/$id");
  }

  Future<Response> registerSale({required VoucherRequestModel voucher}) async {
    Map<String, dynamic> body = {
      "establishment_id": voucher.establishmentId,
      "document_type_id": voucher.documentTypeId,
      "series_id": voucher.seriesId,
      "prefix": voucher.documentTypeId == NOTA_VENTA ? "NV" : voucher.prefix,
      "number": voucher.number,
      "date_of_issue": voucher.dateOfIssue,
      "time_of_issue": voucher.timeOfIssue,
      "customer_id": voucher.customerId,
      "currency_type_id": voucher.currencyTypeId,
      "purchase_order": voucher.purchaseOrder,
      "exchange_rate_sale": voucher.exchangeRateSale,
      "total_prepayment": voucher.totalPrepayment,
      "total_charge": voucher.totalCharge,
      "total_discount": voucher.totalDiscount,
      "total_exportation": voucher.totalExportation,
      "total_free": voucher.totalFree,
      "total_taxed": voucher.totalTaxed,
      "total_unaffected": voucher.totalUnaffected,
      "total_exonerated": voucher.totalExonerated,
      "total_igv": voucher.totalIgv,
      "total_base_isc": voucher.totalBaseIsc,
      "total_isc": voucher.totalIsc,
      "total_base_other_taxes": voucher.totalBaseOtherTaxes,
      "total_other_taxes": voucher.totalOtherTaxes,
      "total_plastic_bag_taxes": voucher.totalPlasticBagTaxes,
      "total_taxes": voucher.totalTaxes,
      "total_value": voucher.totalValue,
      "total": voucher.total,
      "subtotal": voucher.subtotal,
      "total_igv_free": voucher.totalIgvFree,
      "operation_type_id": voucher.operationTypeId,
      "date_of_due": voucher.dateOfDue,
      "items": voucher.items.map((e) => e.toJson()).toList(),
      "charges": voucher.charges,
      "discounts": voucher.discounts,
      "attributes": voucher.attributes,
      "guides": voucher.guides,
      "payments": voucher.payments.map((p) {
        return {
          "id": p.id,
          "document_id": p.documentId,
          "sale_note_id": p.saleNoteId,
          "date_of_payment": p.dateOfPayment,
          "payment_method_type_id": p.paymentMethodTypeId,
          "payment_destination_id": p.paymentDestinationId,
          "reference": p.reference,
          "payment": p.payment,
        };
      }).toList(),
      "hotel": {},
      "additional_information": voucher.additionalInformation,
      "actions": {
        "format_pdf": voucher.actions.formatPdf,
      },
      "reference_data": voucher.referenceData,
      "is_print": voucher.isPrint,
      "worker_full_name_tips": voucher.workerFullNameTips,
      "total_tips": voucher.totalTips,
    };
    String url = "/documents_v1";
    if (voucher.documentTypeId == "80") {
      url = "/sale-notes";
    }
    return await post(url, body);
  }
}
