import 'package:assesment_flutter/database/database.dart';
import 'package:assesment_flutter/database/entity/draftBlockEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../common/common_widgets.dart';
import '../../constants/colors.dart';
import '../../database/entity/completedBlockEntity.dart';
import '../pendingDetails/pending_details_controller.dart';

class DraftController extends GetxController {
  var isLoading = true.obs;
  late MyDatabase database ;
  RxList<Draftblockentity> draftEntityList = <Draftblockentity>[].obs ;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await initializeDb();
  }

  Future<void> initializeDb() async {
    database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
    await  getBlockDataFromDb();
  }

  void clearList() {
    draftEntityList.clear() ;
  }

  Future<void> getBlockDataFromDb() async{
    var data = await database.draftDao.getAllDraftBlocks() ;
    if(data.isNotEmpty) {
      draftEntityList(data) ;
      isLoading(false);
      update();
    } else {
      MyWidgets.showValidationMessage("No data Found", Get.context!);
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> onDeleteClicked(int? id, int index) async {
    isLoading(true);
    await database.draftDao.deleteDraftsById(id!);
    draftEntityList.removeAt(index) ;
    isLoading(false);
    update();
  }

  Future<void> syncDraftData(int index, Draftblockentity entity)async {
    isLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 3));
      Completedblockentity completedblockentity = Completedblockentity(blockName: entity.blockName,
          blockId: entity.blockId, villageList: entity.villageList);
      await database.completedDao.insertCompletedBlock(completedblockentity);
      await database.draftDao.deleteDraftsById(entity.id!);
      draftEntityList.removeAt(index);
      Get.snackbar(
        "Submitted",
        "Data Submit Successfully",
        backgroundColor: colorPrimary,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      isLoading(false);
      update();
    }catch(e){
      isLoading(false);
      debugPrint("ERROR::::::::::${e.toString()}");
    }
  }

  void onClickedCard(Draftblockentity item) {
    Get.delete<PendingDetailsController>();
    Get.toNamed(AppRoutes.pending_details_screen,arguments: item)?.then((value) => onInit(),);
  }
}