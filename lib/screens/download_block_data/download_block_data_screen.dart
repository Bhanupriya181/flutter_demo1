import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/colors.dart';
import 'package:assesment_flutter/screens/download_block_data/download_blockdata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DownloadBlockDataScreen extends GetView<DownloadBlockdataController> {
  final DownloadBlockdataController downloadBlockdataController =
      Get.put(DownloadBlockdataController());

  DownloadBlockDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: downloadBlockdataController,
        builder: (_) {
          return SafeArea(
              child: Obx(
            () => Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            downloadBlockdataController.isDownLoaded.value
                                ? Lottie.asset(
                                    'assets/lotties/success.json',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  )
                                : const Image(
                                    image: AssetImage(
                                      "assets/images/data_download.png",
                                    ),
                                    height: 150,
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            downloadBlockdataController.isDownLoading.value
                                ? const CircularProgressIndicator(
                                    color: colorPrimary,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      downloadBlockdataController
                                          .onClickDownLoadBlockDataBotton();

                                    },
                                    child: Container(
                                      width: 300,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: colorPrimary.withOpacity(0.6),
                                          border:
                                              Border.all(color: colorPrimary),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(
                                            Icons.download_for_offline_outlined,
                                            color: Colors.white,
                                          ),
                                          MyWidgets.showText(
                                              "Download Block Data",
                                              Colors.white,
                                              18,
                                              FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      downloadBlockdataController.isDownLoaded.value
                          ? GestureDetector(
                              onTap: () async {
                                downloadBlockdataController.onClickContinueBotton();

                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: const BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: MyWidgets.showText("Continue",
                                    Colors.white, 18, FontWeight.w500),
                              ),
                            )
                          : Container(),
                    ],
                  )),
            ),
          ));
        });
  }
}
