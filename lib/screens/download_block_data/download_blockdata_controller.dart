import 'dart:convert';

import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/constants.dart';
import 'package:assesment_flutter/database/database.dart';
import 'package:assesment_flutter/database/entity/village_entity.dart';
import 'package:assesment_flutter/model/blockDataResponse.dart';
import 'package:assesment_flutter/utils/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../database/entity/block_entity.dart';

class DownloadBlockdataController extends GetxController {

  RxBool isDownLoading =  false.obs ;
  RxBool isDownLoaded = false.obs ;
  ApiHelper apiHelper = ApiHelper() ;
  late MyDatabase database ;
  @override
  void onInit()async{
    await initializeDb() ;
    super.onInit();
  }

  Future<void> initializeDb() async {
  database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
  }

  Future<void> onClickDownLoadBlockDataBotton() async{
    try{
      isDownLoaded(false);
      isDownLoading(true) ;
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

          Get.snackbar("Download", "Block Data Download Successfully",backgroundColor: colorPrimary,
              colorText: Colors.white,duration: const Duration(seconds: 2));
          isDownLoading(false);
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

  void onClickContinueBotton() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  Future<void> insertBlockData(List<BlockList> blockList) async {
    await database.blockDao.deleteAllBlocks();
    await database.completedDao.deleteAllCompleteData();
    await database.draftDao.deleteAllDraft();
    await database.villageDao.deleteAllVillages() ;
    List<VillageList>? villageList= [] ;
    for (var block in blockList) {
      // Create a BlockEntity with the village list encoded as JSON
      BlockEntity blockEntity = BlockEntity(
        blockName: block.name.toString(),
        blockId: block.id.toString(),
        villageList: block.villageList.toString(), // Pass the villageList
        type: PENDING_TYPE
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
}