import 'package:facturadorpro/app/bindings/filter_cash_box_binding.dart';
import 'package:facturadorpro/app/bindings/filter_client_binding.dart';
import 'package:facturadorpro/app/bindings/filter_product_binding.dart';
import 'package:facturadorpro/app/bindings/presentation_form_binding.dart';
import 'package:facturadorpro/app/ui/pages/filter_cash_box_page/filter_cash_box_page.dart';
import 'package:facturadorpro/app/ui/pages/filter_client_page/filter_client_page.dart';
import 'package:facturadorpro/app/ui/pages/filter_product_page/filter_product_page.dart';
import 'package:facturadorpro/app/ui/pages/categoria_page/categoria_page.dart';
import 'package:facturadorpro/app/ui/pages/marcas_page/marcas_page.dart';
import 'package:facturadorpro/app/ui/pages/cotizacion_page/cotizacion_page.dart';

import 'package:facturadorpro/app/ui/pages/products_page/presentation_form_page/presentation_form_page.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/bindings/auth_binding.dart';
import 'package:facturadorpro/app/bindings/cash_binding.dart';
import 'package:facturadorpro/app/bindings/get_started_binding.dart';
import 'package:facturadorpro/app/ui/pages/client_page/client_form_page.dart';
import 'package:facturadorpro/app/bindings/pos_binding.dart';
import 'package:facturadorpro/app/bindings/validate_domain_binding.dart';
import 'package:facturadorpro/app/ui/pages/auth_page/auth_page.dart';
import 'package:facturadorpro/app/bindings/filter_documents_binding.dart';
import 'package:facturadorpro/app/ui/pages/vouchers/panel_options_page.dart';
import 'package:facturadorpro/app/bindings/client_binding.dart';
import 'package:facturadorpro/app/ui/pages/cash_page/cash_form_page.dart';
import 'package:facturadorpro/app/ui/pages/get_started_page/get_started_page.dart';
import 'package:facturadorpro/app/bindings/menu_binding.dart';
import 'package:facturadorpro/app/ui/pages/menu_page/menu_page.dart';
import 'package:facturadorpro/app/bindings/products_binding.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/filter_vouchers_page.dart';
import 'package:facturadorpro/app/bindings/panel_options_binding.dart';
import 'package:facturadorpro/app/bindings/payment_form_binding.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/filter_sale_notes_page.dart';
import 'package:facturadorpro/app/ui/pages/products_page/product_form_page.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/cart_pos_page.dart';
import 'package:facturadorpro/app/ui/pages/validate_domain_page/validate_domain_page.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/payment_form_page/payment_form_page.dart';
//directorio
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const GetstartPage(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.MENU,
      page: () => MenuPage(),
      bindings: [
        MenuBinding(),
      ],
    ),
    GetPage(
      name: Routes.CART_POS,
      page: () => CartPosPage(),
      binding: PosBinding(),
    ),
    GetPage(
      name: Routes.CATEGORIA_PAGE,
      page: () =>  CategoriaPage(), // Asegúrate de que esta sea la página correcta
      // Aquí debes incluir los bindings necesarios para esta página si los hay
    ),
        GetPage(
      name: Routes.COTIZACION_PAGE,
      page: () =>  CotizacionPage(), // Asegúrate de que esta sea la página correcta
      // Aquí debes incluir los bindings necesarios para esta página si los hay
    ),
        GetPage(
      name: Routes.MARCA_PAGE,
      page: () =>  MarcaPage(), // Asegúrate de que esta sea la página correcta
      // Aquí debes incluir los bindings necesarios para esta página si los hay
    ),
    GetPage(
      name: Routes.PAYMENT_FORM_PAGE,
      page: () => PaymentFormPage(),
      binding: PaymentFormBinding(),
    ),
    GetPage(
      name: Routes.VALIDATE_DOMAIN,
      page: () => ValidateDomainPage(),
      binding: ValidateDomainBinding(),
    ),
    GetPage(
      name: Routes.ADD_CLIENT,
      page: () => const ClientFormPage(),
      bindings: [
        ClientBinding(),
      ],
    ),
    GetPage(
      name: Routes.FILTER_CLIENT,
      page: () => const FilterClientPage(),
      bindings: [
        FilterClientBinding(),
      ],
    ),
    GetPage(
      name: Routes.CASH_FORM_PAGE,
      page: () => const CashFormPage(),
      bindings: [
        CashBinding(),
      ],
    ),
    GetPage(
      name: Routes.FILTER_CASH_BOX,
      page: () => const FilterCashBoxPage(),
      bindings: [
        FilterCashBoxBinding(),
      ],
    ),
    GetPage(
      name: Routes.ADD_PRODUCT,
      page: () => const ProductFormPage(),
      bindings: [
        ProductsBinding(),
      ],
    ),
    GetPage(
      name: Routes.FILTER_PRODUCT,
      page: () => const FilterProductPage(),
      bindings: [
        FilterProductBinding(),
      ],
    ),
    GetPage(
      name: Routes.PRESENTATION_FORM_PAGE,
      page: () => const PresentationFormPage(),
      binding: PresentationFormBinding(),
    ),
    GetPage(
      name: Routes.PANEL_OPTIONS_PAGE,
      page: () => const PanelOptionsPage(),
      bindings: [
        PanelOptionsBinding(),
      ],
    ),
    GetPage(
      name: Routes.FILTER_VOUCHER_PAGE,
      page: () => const FilterVouchersPage(),
      binding: FilterDocumentsBinding(),
    ),
    GetPage(
      name: Routes.FILTER_SALE_NOTE_PAGE,
      page: () => const FilterSaleNotesPage(),
      binding: FilterDocumentsBinding(),
    ),
  ];
}
