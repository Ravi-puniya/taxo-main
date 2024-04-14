import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

class VersionController extends GetxController {
  RxString version = "".obs;
  @override
  void onInit() async {
    _initPackageInfo();
    super.onInit();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
