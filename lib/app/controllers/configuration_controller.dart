import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/constants.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/api/models/configuration_model.dart';

class ConfigurationController extends GetxController {
  GetStorage storage = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());

  String get domain {
    return storage.read("domain");
  }

  RxBool isLoading = false.obs;
  RxString logo = "".obs;
  RxString brandName = "".obs;

  @override
  void onInit() async {
    logo.value = "${domain}/$folder/$image";
    retrieveConfigParams();
    super.onInit();
  }

  Future<void> retrieveConfigParams() async {
    try {
      isLoading.value = true;
      final Response res = await provider.retrieveConfigParams();
      if (res.statusCode == 200) {
        ConfigurationModel result = configurationModelFromJson(
          res.bodyString!,
        );
        Establishment stablishment = result.data.establishment;
        brandName.value = result.data.company.tradeName;
        if (stablishment.logo != null) {
          logo.value = "$domain/${stablishment.logo!}";
        } else {
          Company company = result.data.company;
          logo.value = "$domain/$folder/${company.logo}";
        }
      }
    } catch (error) {
      displayErrorMessage();
      logo.value = "$domain/$folder/$image";
    } finally {
      isLoading.value = false;
    }
  }
}
