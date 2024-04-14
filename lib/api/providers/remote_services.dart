import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:facturadorpro/api/models/auth_model.dart';
import 'package:facturadorpro/api/models/data_model.dart';
import 'package:facturadorpro/api/models/global_data_model.dart';

class RemoteServices {
  static var client = http.Client();

//Obtener el token de ingreso
  static Future<Auth?> fetchAuth(
      String email, String password, String url) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json; charset=utf-8"
    };
    var body = jsonEncode({"email": email, "password": password});
    var response = await client.post(
      Uri.parse(url),
      body: body,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return authFromJson(jsonString);
    } else {
      return null;
    }
  }

  // Fetch general data
  static Future<GlobalData?> fetchGlobalData(String url, String token) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token"
    };

    var response = await client.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return globalDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  // Datos gráficos del Dashboard
  static Future<DataGraph?> fetchGraph(
    String url,
    String token,
    String period,
    String monthStart,
    String monthEnd,
    String dateStart,
    String dateEnd,
  ) async {
    Map<String, String> requestHeaders = {
      //"Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token"
    };

    Map<String, dynamic> body = {
      //"item_id": null,
      "establishment_id": "1",
      //"enabled_expense": null,
      "enabled_move_item": "false",
      "enabled_transaction_customer": "false",
      "period": period,
      "date_start": dateStart,
      "date_end": dateEnd,
      "month_start": monthStart,
      "month_end": monthEnd,
      //"customer_id": null
    };

    var response = await client.post(
      Uri.parse(url),
      body: body,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return dataGraphFromJson(jsonString);
    } else {
      return null;
    }
  }
}
