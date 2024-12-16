import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/database/entity/block_entity.dart';
import 'package:get/get.dart';

import '../../database/database.dart';
import '../pendingDetails/pending_details_controller.dart';

class PendingController extends GetxController {
  late MyDatabase database ;
  RxList<BlockEntity> blockEntityList = <BlockEntity>[].obs ;
  var isDataLoading = true.obs ;

  @override
  void onInit() async{
    clearList();
    await initializeDb() ;
    super.onInit();
  }

  Future<void> initializeDb() async {
    database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
    await  getBlockDataFromDb();
  }

    void clearList() {
      blockEntityList.clear() ;
    }

  Future<void> getBlockDataFromDb() async{
    var data = await database.blockDao.getAllBlocks() ;
    if(data.isNotEmpty) {
      blockEntityList(data) ;
      isDataLoading(false);
      update();
    } else {
      MyWidgets.showValidationMessage("No data Found", Get.context!);
      isDataLoading(false);
    }
  }

  void onClickedCard(BlockEntity item) {
    Get.delete<PendingDetailsController>();
    Get.toNamed(AppRoutes.pending_details_screen,arguments: item)?.then((value) => onInit(),);
  }

  void onDeleteClicked(int? id, int index)async {
    isDataLoading(true);
    await database.blockDao.deleteBlocksById(id!);
    blockEntityList.removeAt(index) ;
    isDataLoading(false);
    update();
  }
}