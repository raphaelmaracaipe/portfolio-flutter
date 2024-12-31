import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@Injectable(as: $AppRouter)
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: UiSplashRoute.page,
          initial: true,
          keepHistory: false,
        ),
        AutoRoute(
          page: UiAuthRoute.page,
          path: "/${UiAuthRoute.name}",
        ),
        AutoRoute(
          page: UiValidCodeRoutes.page,
          path: "/${UiValidCodeRoutes.name}",
        ),
        AutoRoute(
          page: UiCountryRoute.page,
          path: "/${UiCountryRoute.name}",
        ),
        AutoRoute(
          page: UiProfileRoute.page,
          path: "/${UiProfileRoute.name}",
        ),
        AutoRoute(
          page: UiContactRoutes.page,
          path: "/${UiContactRoutes.name}",
        ),
        AutoRoute(
          page: UiMessageRoutes.page,
          path: "/${UiMessageRoutes.name}",
        ),
      ];
}
