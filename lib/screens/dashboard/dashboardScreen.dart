import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/colors.dart';
import 'package:assesment_flutter/screens/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends GetView<DashboardController> {
  final DashboardController dashboardController = Get.put(DashboardController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init:dashboardController,builder: (_){
      return  SafeArea(child: Obx(() => Scaffold(
        body: dashboardController.isDownLoading.value?
         Center(
          child:MyWidgets.showLoader()
        )
            :SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: colorPrimary,
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.yellow
                                        )
                                    )
                                ),
                                child: const Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.white,
                                      letterSpacing: 1
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  dashboardController.onPressLogout();
                                },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/images/shutdown.png",height: 40,),
                                  )),
                            ],
                          ),
                        )
                    ),
                    const SizedBox(height: 60),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Welcome, \n${dashboardController.user.value}',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:(){
                              dashboardController.onClickDownLoadBlockDataBotton();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Download Block data button',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/share.png',
                            height: 40,
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GetBuilder<DashboardController>(
                                  builder: (controller) {
                                    return SizedBox(
                                      height: 144,
                                      width: 144,
                                      child: SfCircularChart(
                                        margin: EdgeInsets.zero,
                                        legend: Legend(isVisible: false),
                                        series: <DoughnutSeries<PieData, String>>[
                                          DoughnutSeries<PieData, String>(
                                            explode: true,
                                            explodeIndex: controller.explodedIndex,
                                            onPointTap: (ChartPointDetails details) {
                                              controller.toggleExplosion(details.pointIndex!);
                                            },
                                            dataSource: dashboardController.pieRingData,
                                            xValueMapper: (PieData data, _) => data.xData,
                                            yValueMapper: (PieData data, _) => data.yData,
                                            dataLabelMapper: (PieData data, _) => data.text,
                                            dataLabelSettings: const DataLabelSettings(
                                              isVisible: false,
                                              labelPosition: ChartDataLabelPosition.inside,
                                            ),
                                            pointColorMapper: (PieData data, _) => data.color,
                                            radius: '100%',
                                            innerRadius: '50%',
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:155,
                                    padding:const EdgeInsets.only(bottom: 8,right: 2,left: 2,top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[500]!.withOpacity(0.5)
                                            )
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/images/pending.png",height: 20,color: Colors.orangeAccent,),
                                            const SizedBox(width: 10,),
                                            MyWidgets.showText("Pending", Colors.grey[600]!, 15, FontWeight.w500),
                                          ],
                                        ),
                                        MyWidgets.showText(dashboardController.pendingEntityList.length.toString(), Colors.black, 16, FontWeight.w600),
                                      ],),
                                  ),
                                  Container(
                                    width: 155,
                                    padding:const EdgeInsets.only(bottom: 8,right: 2,left: 2,top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[500]!.withOpacity(0.5)
                                            )
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/images/checked.png",height: 20,color: Colors.green,),
                                            const SizedBox(width: 10,),
                                            MyWidgets.showText("Completed", Colors.grey[600]!, 15, FontWeight.w500),
                                          ],
                                        ),
                                        MyWidgets.showText(dashboardController.completedEntityList.length.toString(), Colors.black, 16, FontWeight.w600),
                                      ],),
                                  ),
                                  Container(
                                    width: 155,
                                    padding:const EdgeInsets.only(bottom: 8,right: 2,left: 2,top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[500]!.withOpacity(0.5)
                                            )
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/images/draft.png",height: 20,),
                                            const SizedBox(width: 10,),
                                            MyWidgets.showText("Draft", Colors.grey[600]!, 15, FontWeight.w500),
                                          ],
                                        ),
                                        MyWidgets.showText(dashboardController.draftEntityList.length.toString(), Colors.black, 16, FontWeight.w600),
                                      ],),
                                  ),
                                ],
                              )
                            ],),
                           SizedBox(
                            height: 200,
                            width:210,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                                Text(
                                  dashboardController.totalData.value.toString(),
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    dashboardController.onClickPending();
                  },
                  child: Card(
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02),
                              child: CircleAvatar(
                                radius:
                                MediaQuery.of(context).size.height *
                                    0.03,
                                backgroundColor: colorPrimary,
                                child: Image.asset(
                                  "assets/images/pending.png",
                                  color: Colors.orangeAccent,
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                  width: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " Go to Pending",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontSize: 28,
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.022,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.04,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                      colorPrimary,
                                      radius: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.015,
                                      child: Text(
                                        dashboardController
                                            .pendingEntityList.length
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                ),
                                Text(
                                  ' Click here to Go to Pending. ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight:
                                        Radius.circular(12))),
                                height: 30,
                                width: 35,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_right)
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    dashboardController.onClickCompleted();
                  },
                  child: Card(
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02),
                              child: CircleAvatar(
                                radius:
                                MediaQuery.of(context).size.height *
                                    0.03,
                                backgroundColor: colorPrimary,
                                child: Image.asset(
                                  "assets/images/checked.png",
                                  color: Colors.green,
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                  width: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " Go to Completed",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontSize: 28,
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.022,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.04,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                      colorPrimary,
                                      radius: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.015,
                                      child: Text(
                                        dashboardController
                                            .completedEntityList.length
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                ),
                                Text(
                                  ' Click here to Go to Complete. ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight:
                                        Radius.circular(12))),
                                height: 30,
                                width: 35,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_right)
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    dashboardController.onClickDraftData();
                  },
                  child: Card(
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02),
                              child: CircleAvatar(
                                radius:
                                MediaQuery.of(context).size.height *
                                    0.03,
                                backgroundColor: colorPrimary,
                                child: Image.asset(
                                  "assets/images/draft.png",
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                  width: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " Go to draft",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontSize: 28,
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.022,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.04,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                      colorPrimary,
                                      radius: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.015,
                                      child: Text(
                                        dashboardController
                                            .draftEntityList.length
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                ),
                                Text(
                                  ' Click here to Go to Draft. ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight:
                                        Radius.circular(12))),
                                height: 30,
                                width: 35,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_right)
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),


            ],
          ),
        ),
      )));
    });
  }
}

class PieData {
  PieData(this.xData, this.yData, this.color, [this.text]);

  final String xData;
  final num yData;
  final Color color;
  String? text;
}