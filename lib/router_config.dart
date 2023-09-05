import 'package:flttr_exp/ui/_ui.dart';
import 'package:flttr_exp/ui/pages/phone_validator.dart';
import 'package:flttr_exp/ui/pages/sliver_list_w_headers.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouterConfiguration = GoRouter(routes: [
  GoRoute(
      path: HomePage.routeName,
      builder: (ctx, state) => const HomePage(),
      routes: [
        GoRoute(
            name: CustomButtonPage.routeName,
            path: CustomButtonPage.routeName,
            builder: (ctx, state) => const CustomButtonPage()),
        GoRoute(
          name: SliverListWHeaders.routeName,
          path: SliverListWHeaders.routeName,
          builder: (ctx, state) => const SliverListWHeaders()
        ),
        GoRoute(
          name: PhoneValidatorPage.routeName,
          path: PhoneValidatorPage.routeName,
          builder: (ctx, state) => const PhoneValidatorPage()
        ),
      ]),
]);
