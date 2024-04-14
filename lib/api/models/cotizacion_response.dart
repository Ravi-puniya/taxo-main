import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CotizacionResponse {
  final bool success;
  final CotizacionData data;

  CotizacionResponse({
    required this.success,
    required this.data,
  });

  factory CotizacionResponse.fromJson(Map<String, dynamic> json) {
    return CotizacionResponse(
      success: json['success'] ?? false,
      data: CotizacionData.fromJson(json['data'] ?? {}),
    );
  }
}

class CotizacionData {
  final String numberFull;
  final String externalId;
  final String filename;
  final String printA4;
  final String printTicket;

  CotizacionData({
    required this.numberFull,
    required this.externalId,
    required this.filename,
    required this.printA4,
    required this.printTicket,
  });

  factory CotizacionData.fromJson(Map<String, dynamic> json) {
    return CotizacionData(
      numberFull: json['number_full'] ?? '',
      externalId: json['external_id'] ?? '',
      filename: json['filename'] ?? '',
      printA4: json['print_a4'] ?? '',
      printTicket: json['print_ticket'] ?? '',
    );
  }
}
