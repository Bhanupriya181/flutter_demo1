import 'package:assesment_flutter/screens/draft/draft_controller.dart';
import 'package:get/get.dart';

class DraftBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => DraftController(),);
  }

}