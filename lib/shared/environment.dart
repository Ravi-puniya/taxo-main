import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return ".env.production";
    }
    return ".env.development";
  }

  static String get businessDomain {
    return dotenv.env["BUSINESS_DOMAIN"] ?? "BUSINESS_DOMAIN not found";
  }
}
