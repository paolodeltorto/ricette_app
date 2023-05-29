import 'package:auto_route/auto_route.dart';
import 'package:ricette_app/pages/home_page.dart';
import 'package:ricette_app/pages/welcome_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePage, initial: true),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}
