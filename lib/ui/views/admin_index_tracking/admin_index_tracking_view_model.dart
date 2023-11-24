import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/global_var.dart';

class AdminIndexTrackingViewModel extends IndexTrackingViewModel {
  final log = getLogger('AdminIndexTrackingViewModel');
  final globalVar = locator<GlobalVar>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  // final mySharedPrefs = locator<MySharedPrefs>();

  final _bottomNavBarList = [
    {
      'name': 'Caleg',
      'icon': Icons.co_present_outlined,
      'header': 'Halaman Caleg',
    },
    {
      'name': 'Tim\nSurvei',
      'icon': Icons.people_outlined,
      'header': 'Tim Survei',
    },
    {
      'name': 'Pengaturan',
      'icon': Icons.settings_outlined,
      'header': 'Halaman Pengaturan',
    },
  ];

  String header = 'Halaman Utama';

  List<Map<String, dynamic>> get bottomNavBarList => _bottomNavBarList;

  final List<String> _views = [
    AdminIndexTrackingViewRoutes.halamanCalegView,
    AdminIndexTrackingViewRoutes.timSurveiView,
    AdminIndexTrackingViewRoutes.halamanPengaturanView,
  ];

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    setIndex(2);
    // await super.init();
  }

  void handleNavigation(int index) {
    // log.d("handleNavigation: $index");
    // log.d("currentIndex: $currentIndex");

    // if (currentIndex == index) return;

    setIndex(index);
    header = _bottomNavBarList[index]['header'] as String;
    navigationService.navigateTo(
      _views[index],
      id: 2,
    );
  }

  logout() async {
    dialogService
        .showConfirmationDialog(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin keluar?',
      cancelTitle: 'Batal',
      confirmationTitle: 'Keluar',
    )
        .then((value) async {
      if (value!.confirmed) {
        // await mySharedPrefs.clear();
        navigationService.clearStackAndShow(Routes.loginScreenView);
      }
    });
  }
}
