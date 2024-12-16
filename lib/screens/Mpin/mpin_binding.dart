import 'package:assesment_flutter/screens/Mpin/mpin_controller.dart';
import 'package:get/get.dart';

class MpinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MpinController(),);
  }

}