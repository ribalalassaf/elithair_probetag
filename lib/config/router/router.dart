import 'package:auto_route/auto_route.dart';
import 'package:elithair_probetag/config/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes => [AutoRoute(page: HistoryRoute.page, initial: true), AutoRoute(page: FormRoute.page)];
}
