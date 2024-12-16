import 'dart:convert';
import 'dart:io';

import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/database/entity/completedBlockEntity.dart';
import 'package:assesment_flutter/database/entity/draftBlockEntity.dart';
import 'package:assesment_flutter/screens/completed/complete_contrller.dart';
import 'package:assesment_flutter/screens/draft/draft_controller.dart';
import 'package:assesment_flutter/utils/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/common_widgets.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../database/database.dart';
import '../../database/entity/block_entity.dart';
import '../../database/entity/village_entity.dart';
import '../../model/blockDataResponse.dart';
import '../pending_screen/pending_controller.dart';
import 'dashboardScreen.dart';

class DashboardController extends GetxController {
  int? explodedIndex;
  int? explodedindexRing;
  int? explodedindexPie;
  var isDownLoaded = false.obs ;
  var isDownLoading = true.obs ;
  ApiHelper apiHelper = ApiHelper();
  var caseCountDraftData = "".obs ;
  late MyDatabase database ;
  RxList<BlockEntity> pendingEntityList = <BlockEntity>[].obs ;
  RxList<Draftblockentity> draftEntityList = <Draftblockentity>[].obs ;
  RxList<Completedblockentity> completedEntityList = <Completedblockentity>[].obs ;
  var totalData = 0.obs ;
  var user = "".obs ;

  Future<void> initializeDb() async {
    database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
    await getDbData();
  }
  @override
  void onInit()async{
    super.onInit();
    await initializeDb();

  }

  void toggleExplosion(int pointIndex) {
    if (explodedIndex == pointIndex) {
      explodedIndex = null;
    } else {
      explodedIndex = pointIndex;
    }
    update(); // Update the UI
  }

  List<PieData> pieRingData = [
    PieData('Pending', 30, Colors.orangeAccent, '30%'),
    PieData('Completed', 70, Colors.blue.shade800, '70%'),
    PieData('Draft', 70, Colors.blue.shade800, '70%'),
  ];

  void onClickDraftData() {
    Get.delete<DraftController>();
    Get.toNamed(AppRoutes.draftScreen)?.then((value) => onInit());
    update() ;
  }

  void onClickCompleted() {
    Get.delete<CompleteContrller>();
    Get.toNamed(AppRoutes.completeScreen)?.then((value) => onInit());
    update() ;
  }

  void onClickPending() {
    Get.delete<PendingController>();
    Get.toNamed(AppRoutes.pending_screen)?.then((value) => onInit());
    update();
  }

  Future<void> onClickDownLoadBlockDataBotton() async{
    try{
      isDownLoaded(false);
      isDownLoading(true) ;
      clearList();
      final response =await apiHelper.blockDataDownload();
      debugPrint("$response");
      if (response != null || response.toString() != "null") {
        if (response!.statusCode == 200) {

          // Ensure response.data is a map or string
          Map<String, dynamic> jsonResponse;
          if (response.data is String) {
            jsonResponse = json.decode(response.data);
          }else if (response.data is Map<String, dynamic>) {
            jsonResponse = response.data;
          }else {
            isDownLoading(false);
            isDownLoaded(false);
            throw Exception("Unexpected response format");
          }

          // Parse the JSON data
          BlockDataResponse blockDataResponse = BlockDataResponse.fromJson(jsonResponse);
          await insertBlockData(blockDataResponse.blockList!);

          var pendingEntity = await database.blockDao.getAllBlocks() ;
          var completedEntity = await database.completedDao.getAllCompletedBlocks() ;
          var draftEntity = await database.draftDao.getAllDraftBlocks() ;

          if(pendingEntity.isNotEmpty) {
            pendingEntityList(pendingEntity);
          }
          if(completedEntity.isNotEmpty){
            completedEntityList(completedEntity) ;
          }
          if(draftEntity.isNotEmpty) {
            draftEntityList(draftEntity);
          }

          totalData.value = pendingEntityList.length+ completedEntityList.length+draftEntityList.length ;

          pieRingData.clear();
          pieRingData.add( PieData('Pending', pendingEntityList.length, Colors.orangeAccent, '${pendingEntityList.length}%'),);
          pieRingData.add( PieData('Completed', completedEntityList.length, Colors.green.shade700, '${completedEntityList.length}%'),);
          pieRingData.add( PieData('Draft', draftEntityList.length, Colors.blue.shade700, '${draftEntityList.length}%'),);

          getDbData() ;
          update();
          isDownLoading(false);
          Get.snackbar("Download", "Block Data Download Successfully",backgroundColor: colorPrimary,
              colorText: Colors.white,duration: const Duration(seconds: 2));

        } else {
          isDownLoading(false);
          isDownLoaded(false);
        }
      } else {
        MyWidgets.showValidationMessage("Something went wrong please download again", Get.context!);
        isDownLoading(false);
        isDownLoaded(false);
      }
    } catch(e){
      debugPrint("error!!!!!!!!!!!!${e.toString()}");
      MyWidgets.showValidationMessage("Something went wrong please download again", Get.context!);
      isDownLoading(false);
      isDownLoaded(false);
    }
  }

  Future<void> insertBlockData(List<BlockList> blockList) async {
    await database.draftDao.deleteAllDraft();
    await database.completedDao.deleteAllCompleteData();
    await database.blockDao.deleteAllBlocks();
    await database.villageDao.deleteAllVillages() ;

    List<VillageList>? villageList= [] ;

    for (var block in blockList) {
      // Create a BlockEntity with the village list encoded as JSON
      BlockEntity blockEntity = BlockEntity(
        blockName: block.name.toString(),
        blockId: block.id.toString(),
        villageList: block.villageList.toString(),
        type: PENDING_TYPE// Pass the villageList
      );

      villageList = block.villageList ;
      if(villageList != null) {
        for(var village in villageList) {
          VillageEntity villageEntity = VillageEntity(
              villageName: village.vName.toString(),
              image: village.image.toString(),
              date: village.date.toString(),
              remark: village.remarks.toString(),
              blockId: block.id.toString()) ;
          await database.villageDao.insertVillage(villageEntity);
        }
      }
      // Insert into the database
      await database.blockDao.insertBlock(blockEntity);

    }
    await Constants.instance.saveBooleanValue(IS_BLOCK_DATA_DOWNLOADED, true) ;
    isDownLoaded(true);
  }


  Future<void> getDbData()async {
    var pendingEntity = await database.blockDao.getAllBlocks() ;
    var completedEntity = await database.completedDao.getAllCompletedBlocks() ;
    var draftEntity = await database.draftDao.getAllDraftBlocks() ;

    if(pendingEntity.isNotEmpty) {
      pendingEntityList(pendingEntity);
    }
    if(completedEntity.isNotEmpty){
      completedEntityList(completedEntity) ;
    }
    if(draftEntity.isNotEmpty) {
      draftEntityList(draftEntity);
    }

    totalData.value = pendingEntityList.length+ completedEntityList.length+draftEntityList.length ;

    pieRingData.clear();
    pieRingData.add( PieData('Pending', pendingEntityList.length, Colors.orangeAccent, '${pendingEntityList.length}%'),);
    pieRingData.add( PieData('Completed', completedEntityList.length, Colors.green.shade700, '${completedEntityList.length}%'),);
    pieRingData.add( PieData('Draft', draftEntityList.length, Colors.blue.shade700, '${draftEntityList.length}%'),);


    var email = await Constants.instance.getStringValue(USER_EMAIL);
    if(email != null) {
      user(email);
    }
    isDownLoading(false);
  }

  void onPressLogout() async{
   await wiiPopDialog() ;
  }

  Future<bool?> wiiPopDialog() async {
    return (await Get.dialog(
        barrierDismissible: true,
        AlertDialog(
          icon: const Icon(
            CupertinoIcons.exclamationmark_shield,
            color: Color(0xffe34234),
            size: 60,
          ),
          elevation: 50,
          actionsPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Text(
                "Are you sure, you want to Logout !",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    fontSize: 15),
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                  deleteAppDataPermanently();
                },
                child: Container(
                    width: MediaQuery.of(Get.context!).size.width * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      border: Border.all(
                        width: 1.0,
                        color: colorPrimary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          "Exit App",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15),
                        )))),
            GestureDetector(
                onTap: () async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
                  sharedPreferences.remove(IS_LOGIN_WITH_MPIN);
                  Get.offAllNamed(AppRoutes.miPinLoginScreen);
                },
                child: Container(
                    width: MediaQuery.of(Get.context!).size.width * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffe34234),
                      border: Border.all(
                        width: 1.0,
                        color: colorPrimary.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15),
                        ))))
          ],
        )));
  }

  void clearList() {
    pendingEntityList.clear() ;
    draftEntityList.clear() ;
    completedEntityList.clear() ;
  }

  void deleteAppDataPermanently() async{
    isDownLoading(true);
    await Constants.instance.removeAllFromSharedPreference() ;
    await database.blockDao.deleteAllBlocks();
    await database.draftDao.deleteAllDraft() ;
    await database.completedDao.deleteAllCompleteData() ;
    await database.villageDao.deleteAllVillages() ;
    isDownLoading(false);
    exit(0);
  }
}
