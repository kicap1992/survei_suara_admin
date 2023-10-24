// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cek_suara/ui/views/admin_index_tracking/admin_first_page/admin_first_page_view.dart'
    as _i6;
import 'package:cek_suara/ui/views/admin_index_tracking/admin_index_tracking_view.dart'
    as _i4;
import 'package:cek_suara/ui/views/admin_index_tracking/halaman_area/halaman_area_view.dart'
    as _i7;
import 'package:cek_suara/ui/views/admin_index_tracking/halaman_caleg/halaman_caleg_view.dart'
    as _i8;
import 'package:cek_suara/ui/views/admin_index_tracking/halaman_pengaturan/halaman_pengaturan_view.dart'
    as _i10;
import 'package:cek_suara/ui/views/admin_index_tracking/tim_survei/tim_survei_view.dart'
    as _i9;
import 'package:cek_suara/ui/views/login_screen/login_screen_view.dart' as _i3;
import 'package:cek_suara/ui/views/splash_screen/splash_screen_view.dart'
    as _i2;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const splashScreenView = '/';

  static const loginScreenView = '/login-screen-view';

  static const adminIndexTrackingView = '/admin-index-tracking-view';

  static const all = <String>{
    splashScreenView,
    loginScreenView,
    adminIndexTrackingView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreenView,
      page: _i2.SplashScreenView,
    ),
    _i1.RouteDef(
      Routes.loginScreenView,
      page: _i3.LoginScreenView,
    ),
    _i1.RouteDef(
      Routes.adminIndexTrackingView,
      page: _i4.AdminIndexTrackingView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreenView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreenView(),
        settings: data,
      );
    },
    _i3.LoginScreenView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginScreenView(),
        settings: data,
      );
    },
    _i4.AdminIndexTrackingView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.AdminIndexTrackingView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AdminIndexTrackingViewRoutes {
  static const adminFirstPageView = '';

  static const halamanAreaView = 'halaman-area-view';

  static const halamanCalegView = 'halaman-caleg-view';

  static const timSurveiView = 'tim-survei-view';

  static const halamanPengaturanView = 'halaman-pengaturan-view';

  static const all = <String>{
    adminFirstPageView,
    halamanAreaView,
    halamanCalegView,
    timSurveiView,
    halamanPengaturanView,
  };
}

class AdminIndexTrackingViewRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      AdminIndexTrackingViewRoutes.adminFirstPageView,
      page: _i6.AdminFirstPageView,
    ),
    _i1.RouteDef(
      AdminIndexTrackingViewRoutes.halamanAreaView,
      page: _i7.HalamanAreaView,
    ),
    _i1.RouteDef(
      AdminIndexTrackingViewRoutes.halamanCalegView,
      page: _i8.HalamanCalegView,
    ),
    _i1.RouteDef(
      AdminIndexTrackingViewRoutes.timSurveiView,
      page: _i9.TimSurveiView,
    ),
    _i1.RouteDef(
      AdminIndexTrackingViewRoutes.halamanPengaturanView,
      page: _i10.HalamanPengaturanView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i6.AdminFirstPageView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.AdminFirstPageView(),
        settings: data,
      );
    },
    _i7.HalamanAreaView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.HalamanAreaView(),
        settings: data,
      );
    },
    _i8.HalamanCalegView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.HalamanCalegView(),
        settings: data,
      );
    },
    _i9.TimSurveiView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.TimSurveiView(),
        settings: data,
      );
    },
    _i10.HalamanPengaturanView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.HalamanPengaturanView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAdminIndexTrackingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.adminIndexTrackingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedAdminFirstPageViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(AdminIndexTrackingViewRoutes.adminFirstPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanAreaViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(AdminIndexTrackingViewRoutes.halamanAreaView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanCalegViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(AdminIndexTrackingViewRoutes.halamanCalegView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedTimSurveiViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(AdminIndexTrackingViewRoutes.timSurveiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanPengaturanViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(
        AdminIndexTrackingViewRoutes.halamanPengaturanView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAdminIndexTrackingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.adminIndexTrackingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedAdminFirstPageViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(AdminIndexTrackingViewRoutes.adminFirstPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanAreaViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(AdminIndexTrackingViewRoutes.halamanAreaView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanCalegViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(AdminIndexTrackingViewRoutes.halamanCalegView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNestedTimSurveiViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(AdminIndexTrackingViewRoutes.timSurveiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanPengaturanViewInAdminIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(
        AdminIndexTrackingViewRoutes.halamanPengaturanView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
