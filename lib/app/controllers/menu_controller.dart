import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/app/routes/app_routes.dart';

class MenuControllers extends GetxController {
  GetStorage box = GetStorage();

  RxString menuTitle = "Dashboard".obs;
  RxInt menuIndex = 0.obs;
  RxInt voucherMenuIndex = 0.obs;
  RxString version = "".obs;

  @override
  void onInit() async {
    await GetStorage.init('domain');
    super.onInit();
  }

  void useNavigator({required int index, required String title}) {
    menuIndex.value = index;
    menuTitle.value = title;
    Get.back();
  }

  void logout() {
    menuIndex.value = 10;
    box.write('success', false);
    Get.offAllNamed(Routes.AUTH);
  }

  void changeVoucherMenu({required int index, required String title}) {
    voucherMenuIndex.value = index;
    menuTitle.value = title;
  }
//directorio
  navigatorCartPos() => Get.toNamed(Routes.CART_POS);
  navigatorCashFormPage() => Get.toNamed(Routes.CASH_FORM_PAGE);
  navigatorCashBoxFilterPage() => Get.toNamed(Routes.FILTER_CASH_BOX);
  navigatorClientFormPage() => Get.toNamed(Routes.ADD_CLIENT);
  navigatorClientFilterPage() => Get.toNamed(Routes.FILTER_CLIENT);
  navigatorProductFormPage() => Get.toNamed(Routes.ADD_PRODUCT);
  navigatorProductFilterPage() => Get.toNamed(Routes.FILTER_PRODUCT);
  navigatorcategoriaPage() => Get.toNamed(Routes.CATEGORIA_PAGE);
  navigatormarcaPage() => Get.toNamed(Routes.MARCA_PAGE);
  navigatorcotizacionPage() => Get.toNamed(Routes.COTIZACION_PAGE);
  
}
