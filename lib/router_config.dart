import 'package:flttr_exp/ui/_ui.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouterConfiguration = GoRouter(routes: [
  GoRoute(
      path: HomePage.routeName,
      builder: (ctx, state) => const HomePage(),
      routes: [
        GoRoute(
            name: CustomButtonPage.routeName,
            path: CustomButtonPage.routeName,
            builder: (ctx, state) => const CustomButtonPage())
      ]),
]);
