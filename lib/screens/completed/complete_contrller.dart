import 'package:assesment_flutter/database/database.dart';
import 'package:assesment_flutter/database/entity/completedBlockEntity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../common/common_widgets.dart';
import '../pendingDetails/pending_details_controller.dart';

class CompleteContrller extends GetxController {
  var isLoading = true.obs;
  late MyDatabase database ;
  RxList<Completedblockentity> completeEntityList = <Completedblockentity>[].obs ;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     initializeDb();
  }

  Future<void> initializeDb() async {
    try {
      database = await $FloorMyDatabase.databaseBuilder('my_database.db').build();
      await getBlockDataFromDb();
    } catch (e) {
      debugPrint("Database initialization error: $e");
      isLoading(false); // Stop loading if there's an error
    }
  }

  void clearList() {
    completeEntityList.clear() ;
  }

  Future<void> getBlockDataFromDb() async {
    var data = await database.completedDao.getAllCompletedBlocks();
    if (data.isNotEmpty) {
      completeEntityList.assignAll(data); // Use assignAll to update the observable list
    } else {
      MyWidgets.showValidationMessage("No data found", Get.context!);
    }
    isLoading(false); // Stop loading here
  }

  Future<void> onDeleteClicked(int? id, int index) async {
    if (id != null) {
      isLoading(true);
      await database.completedDao.deleteCompletedsById(id);
      completeEntityList.removeAt(index);
      isLoading(false);
    }
  }

  void onClickedCard(Completedblockentity item) {
    Get.delete<PendingDetailsController>();
    Get.toNamed(AppRoutes.pending_details_screen,arguments: item)?.then((value) => onInit(),);
  }
}