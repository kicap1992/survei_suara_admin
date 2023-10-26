import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

import '../services/global_var.dart';
import '../services/http_services.dart';
import '../services/my_easyloading.dart';
import '../services/other_function.dart';
import '../ui/views/admin_index_tracking/admin_first_page/admin_first_page_view.dart';
import '../ui/views/admin_index_tracking/admin_index_tracking_view.dart';
import '../ui/views/admin_index_tracking/halaman_area/halaman_area_view.dart';
import '../ui/views/admin_index_tracking/halaman_caleg/halaman_caleg_view.dart';
import '../ui/views/admin_index_tracking/halaman_caleg/tambah_edit_caleg/tambah_edit_caleg_view.dart';
import '../ui/views/admin_index_tracking/halaman_pengaturan/halaman_pengaturan_view.dart';
import '../ui/views/admin_index_tracking/tim_survei/tambah_detail_tim_survei/tambah_detail_tim_survei_view.dart';
import '../ui/views/admin_index_tracking/tim_survei/tim_survei_view.dart';
import '../ui/views/login_screen/login_screen_view.dart';
import '../ui/views/splash_screen/splash_screen_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: LoginScreenView),
    MaterialRoute(
      page: AdminIndexTrackingView,
      children: [
        MaterialRoute(
          page: AdminFirstPageView,
          initial: true,
        ),
        MaterialRoute(
          page: HalamanAreaView,
        ),
        MaterialRoute(
          page: HalamanCalegView,
        ),
        MaterialRoute(
          page: TimSurveiView,
        ),
        MaterialRoute(
          page: HalamanPengaturanView,
        ),
      ],
    ),
  ],
  dialogs: [
    StackedDialog(classType: TambahEditCalegView),
    StackedDialog(classType: TambahDetailTimSurveiView)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    //
    // LazySingleton(classType: UserHomeView),
    // LazySingleton(classType: PengembangHomeView),
    LazySingleton(classType: MyEasyLoading),
    LazySingleton(classType: MyHttpServices),
    LazySingleton(classType: GlobalVar),
    LazySingleton(classType: MyFunction),
  ],
  logger: StackedLogger(),
)
class App {}
