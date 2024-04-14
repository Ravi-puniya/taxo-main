import 'package:get/get.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';

import 'package:permission_handler/permission_handler.dart';

class DirectoryController extends GetxController {
  RxString downloadDir = "".obs;

  @override
  void onInit() async {
    await onInitDownloadDirectory();
    super.onInit();
  }

  Future<void> onInitDownloadDirectory() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      var dir = await DownloadsPath.downloadsDirectory();
      if (dir != null) {
        downloadDir.value = dir.path;
      }
    }
  }
}
