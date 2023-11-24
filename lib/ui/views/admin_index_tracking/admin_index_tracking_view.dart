import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../app/app.router.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_text.dart';
import './admin_index_tracking_view_model.dart';

class AdminIndexTrackingView extends StatelessWidget {
  const AdminIndexTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminIndexTrackingViewModel>.reactive(
      viewModelBuilder: () => AdminIndexTrackingViewModel(),
      onViewModelReady: (AdminIndexTrackingViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        AdminIndexTrackingViewModel model,
        Widget? child,
      ) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                model.header,
                style: const TextStyle(
                  color: fontColor,
                  fontSize: 20,
                ),
              ),
              backgroundColor: warningColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    model.logout();
                  },
                  icon: const Icon(Icons.logout, color: fontColor),
                ),
              ],
            ),
            extendBody: false,
            body: ExtendedNavigator(
              router: AdminIndexTrackingViewRouter(),
              navigatorKey: StackedService.nestedNavigationKey(2),
            ),
            bottomNavigationBar: StylishBottomBar(
              items: [
                for (var item in model.bottomNavBarList)
                  BottomBarItem(
                    icon: Icon(item['icon'],
                        color: model.currentIndex ==
                                model.bottomNavBarList.indexOf(item)
                            ? warningColor
                            : fontColor),
                    title: Text(
                      item['name'],
                      style: regularTextStyle.copyWith(
                        color: model.currentIndex ==
                                model.bottomNavBarList.indexOf(item)
                            ? warningColor
                            : fontColor,
                      ),
                      // textAlign: TextAlign.l,
                    ),
                    backgroundColor: model.currentIndex ==
                            model.bottomNavBarList.indexOf(item)
                        ? fontColor
                        : fontColor,
                  ),
              ],
              currentIndex: model.currentIndex,
              option: BubbleBarOptions(),
              hasNotch: true,
              backgroundColor: warningColor,
              onTap: (value) {
                model.handleNavigation(value);
              },
              // fabLocation: StylishBarFabLocation.center,
            ),
          ),
        );
      },
    );
  }
}
