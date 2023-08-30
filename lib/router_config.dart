import 'package:flttr_exp/ui/_ui.dart';
import 'package:flttr_exp/ui/pages/animated_list_exmp.dart';
import 'package:flttr_exp/ui/pages/chips.dart';
import 'package:flttr_exp/ui/pages/contacts_page.dart';
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
          name: AnimatedListExmp.routeName,
          path: AnimatedListExmp.routeName,
          builder: (ctx, state) => const AnimatedListExmp()
        ),
        GoRoute(
          name: ContactsPage.routeName,
          path: ContactsPage.routeName,
          builder: (ctx, state) => const ContactsPage()
        ),
        GoRoute(
          name: ChipsExample.routeName,
          path: ChipsExample.routeName,
          builder: (ctx, state) => const ChipsExample()
        ),
      ]),
]);
