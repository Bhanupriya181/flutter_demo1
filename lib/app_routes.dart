
import 'package:assesment_flutter/screens/Mpin/mpin_binding.dart';
import 'package:assesment_flutter/screens/Mpin/mpin_screen.dart';
import 'package:assesment_flutter/screens/completed/complete_screen.dart';
import 'package:assesment_flutter/screens/completed/completed_binding.dart';
import 'package:assesment_flutter/screens/dashboard/dashboardScreen.dart';
import 'package:assesment_flutter/screens/dashboard/dashboard_binding.dart';
import 'package:assesment_flutter/screens/download_block_data/download_block_data_binding.dart';
import 'package:assesment_flutter/screens/download_block_data/download_block_data_screen.dart';
import 'package:assesment_flutter/screens/draft/draftScreen.dart';
import 'package:assesment_flutter/screens/draft/draft_binding.dart';
import 'package:assesment_flutter/screens/login/login_binding.dart';
import 'package:assesment_flutter/screens/login/login_screen.dart';
import 'package:assesment_flutter/screens/miPInLoginScreen/Mi_pin_login_screen.dart';
import 'package:assesment_flutter/screens/miPInLoginScreen/mi_pin_login_binding.dart';
import 'package:assesment_flutter/screens/pendingDetails/pending_details_binding.dart';
import 'package:assesment_flutter/screens/pendingDetails/pending_details_screen.dart';
import 'package:assesment_flutter/screens/pending_screen/pending_binding.dart';
import 'package:assesment_flutter/screens/pending_screen/pending_screen.dart';
import 'package:assesment_flutter/screens/splash/splash_binding.dart';
import 'package:assesment_flutter/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String loginScreen = "/login_screen";
  static const String mpinScreen = "/mpin_Screen";
  static const String downloadBlockData = "/downLoadBlockData";
  static const String miPinLoginScreen = "/miPinLoginScreen";
  static const String dashboard = "/dashboard_screen";
  static const String pending_screen = "/pending_screen";
  static const String pending_details_screen = "/pending_details_screen";
  static const String draftScreen = "/draft_screen";
  static const String completeScreen = "/complete_screen";


  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: mpinScreen,
      page: () => MpinScreen(),
      bindings: [
        MpinBinding(),
      ],
    ),
    GetPage(
      name: downloadBlockData,
      page: () => DownloadBlockDataScreen(),
      bindings: [
        DownloadBlockDataBinding(),
      ],
    ),
    GetPage(
      name: miPinLoginScreen,
      page: () => MiPinLoginScreen(),
      bindings: [
        MiPinLoginBinding(),
      ],
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
      ],
    ),
    GetPage(
      name: pending_screen,
      page: () => PendingScreen(),
      bindings: [
        PendingBinding(),
      ],
    ),
    GetPage(
      name: pending_details_screen,
      page: () => PendingDetailsScreen(),
      bindings: [
        PendingDetailsBinding(),
      ],
    ),
    GetPage(
      name: draftScreen,
      page: () => Draftscreen(),
      bindings: [
        DraftBinding(),
      ],
    ),
    GetPage(
      name: completeScreen,
      page: () => CompleteScreen(),
      bindings: [
        CompletedBinding(),
      ],
    ),
  ];
}
