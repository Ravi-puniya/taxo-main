import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:facturadorpro/shared/environment.dart';
import 'package:facturadorpro/app/routes/app_pages.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/theme/light_theme.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:facturadorpro/api/services/categoria_service.dart'; // Asegúrate de importar CategoriaService aquí
import 'package:facturadorpro/api/services/marcas_service.dart';
import 'package:facturadorpro/api/services/cotizacion_service.dart';

void main() async {
  await dotenv.load(fileName: Environment.fileName);
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  Get.put(CategoriaService()); // O Get.lazyPut()
  Get.put(MarcasService()); // O Get.lazyPut()
  Get.put(CotizacionService());

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white, systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.black, // status bar color
  ));

  runApp(
    GetMaterialApp(
      scrollBehavior: MyBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: GetStorage().read('success') == null
          ? Routes.INITIAL
          : !GetStorage().read('success')
              ? GetStorage().read('domain') == null
                  ? Routes.INITIAL
                  : Routes.AUTH
              : Routes.MENU,
      theme: appThemeData,
      defaultTransition: Transition.circularReveal,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en',"US"),
      ],
      locale: const Locale('en',"US"),
    ),
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
