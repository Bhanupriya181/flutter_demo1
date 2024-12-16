import 'package:get/get.dart';

import 'complete_contrller.dart';

class CompletedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompleteContrller(),);
  }

}