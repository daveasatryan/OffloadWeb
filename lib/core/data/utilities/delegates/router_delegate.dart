import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';

class AppRouterDelegate extends GetDelegate {
  final _key = GlobalKey<NavigatorState>();

  GetNavConfig get prevRoute => history.length < 2 ? history.last : history[history.length - 2];

  @override
  Future<GetNavConfig> popHistory() async {
    final result = prevRoute;
    Get.rootDelegate.toNamed(prevRoute.currentPage?.name ?? AppRoutes.mainRoute);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _key,
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration?.currentPage ?? unknownRoute()]
          : [GetNavConfig.fromRoute(AppRoutes.mainRoute)?.currentPage ?? unknownRoute()],
    );
  }

  GetPage unknownRoute() {
    return GetPage(
      name: '/404',
      page: () => const Scaffold(
        body: Text('Route not found'),
      ),
    );
  }
}
