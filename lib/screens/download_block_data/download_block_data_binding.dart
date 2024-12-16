import 'package:assesment_flutter/screens/download_block_data/download_blockdata_controller.dart';
import 'package:get/get.dart';

class DownloadBlockDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DownloadBlockdataController(),);
  }

}