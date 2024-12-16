import 'package:assesment_flutter/screens/pending_screen/pending_controller.dart';
import 'package:get/get.dart';

class PendingBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => PendingController(),);
  }

}