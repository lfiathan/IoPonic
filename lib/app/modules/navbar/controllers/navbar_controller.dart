import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'dart:convert';
import '../../../routes/app_pages.dart';
import 'package:ioponic/app/modules/ip_setting/controllers/ip_controller.dart';
import '../../../constant/app_colors.dart';

class NavbarController extends GetxController {
  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  // -- Ini adalah cara NavbarController mendapatkan IP dari IpController --
  final IpController ipController = Get.find<IpController>();
  String get baseUrl => ipController.baseUrl;
  final String userId = 'testing';

  final bool isMockMode = true; // Set true to use mock data
  RxInt pakanStatus = 0.obs;
  RxInt siramStatus = 0.obs;

  List<PersistentTabConfig> tabs() => [
        PersistentTabConfig(
          screen: GetRouterOutlet(initialRoute: Routes.HOME),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Beranda",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: AppColors.normalBlue,
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.HOME,
            routes: {
              Routes.HOME: (context) => GetRouterOutlet(
                    initialRoute: Routes.HOME,
                  ),
            },
          ),
        ),
        PersistentTabConfig(
          screen: GetRouterOutlet(
            initialRoute: Routes.SCHEDULE,
          ),
          item: ItemConfig(
            icon: const Icon(Icons.alarm),
            title: "Jadwal",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: AppColors.normalBlue,
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.SCHEDULE,
            routes: {
              Routes.SCHEDULE: (context) => GetRouterOutlet(
                    initialRoute: Routes.SCHEDULE,
                  ),
            },
          ),
        ),
        PersistentTabConfig(
          screen: GetRouterOutlet(
            initialRoute: Routes.FAQ,
          ),
          item: ItemConfig(
            icon: const Icon(Icons.question_answer),
            title: "FAQ",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: AppColors.normalBlue,
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.FAQ,
            routes: {
              Routes.FAQ: (context) => GetRouterOutlet(
                    initialRoute: Routes.FAQ,
                  ),
            },
          ),
        ),
      ];
  //Future<void> waterNow() async {
  //  try {
  //    final response = await http.post(
  //      Uri.parse('$baseUrl/watering'),
  //      headers: {'Content-Type': 'application/json'},
  //      body: jsonEncode(
  //          {'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
  //    );
  //    if (response.statusCode == 200) {
  //      Get.snackbar("Berhasil", "Tanaman telah disiram",
  //          backgroundColor: Colors.green, colorText: Colors.white);
  //    } else {
  //      Get.snackbar("Error", "Gagal menyiram tanaman");
  //    }
  //  } catch (e) {
  //    Get.snackbar("Error", "Terjadi kesalahan: $e");
  //  }
  //}
  //
  //Future<void> feedNow() async {
  //  try {
  //    final response = await http.post(
  //      Uri.parse('$baseUrl/feeding'),
  //      headers: {'Content-Type': 'application/json'},
  //      body: jsonEncode(
  //          {'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
  //    );
  //    if (response.statusCode == 200) {
  //      Get.snackbar("Berhasil", "Pakan telah diberikan",
  //          backgroundColor: Colors.green, colorText: Colors.white);
  //    } else {
  //      Get.snackbar("Error", "Gagal memberi pakan");
  //    }
  //  } catch (e) {
  //    Get.snackbar("Error", "Terjadi kesalahan: $e");
  //  }
  //}
  //
  Future<void> updatePakanStatus(int status) async {
    if (isMockMode) {
      pakanStatus.value = status;
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/pakan/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': 1, 'stat': status}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          pakanStatus.value = data['data']['stat'];
        }
      }
    } catch (e) {
      print("Error updatePakanStatus: $e");
    }
  }

  Future<void> updateSiramStatus(int status) async {
    if (isMockMode) {
      siramStatus.value = status;
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/siram/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': 1, 'stat': status}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          siramStatus.value = data['data']['stat'];
        }
      }
    } catch (e) {
      print("Error updateSiramStatus: $e");
    }
  }
}
