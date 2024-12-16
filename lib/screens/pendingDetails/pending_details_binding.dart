import 'package:assesment_flutter/screens/pendingDetails/pending_details_controller.dart';
import 'package:get/get.dart';

class PendingDetailsBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => PendingDetailsController(),);
  }

}