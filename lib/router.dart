import 'package:flutter/material.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';

class AppRouter {
  static Route onGeneratedRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case LoginPage.loginPageRouterName:
        return MaterialPageRoute(builder: (_) => LoginPage());
        case HomePage.homepageRouteName:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return null;
    }
  }
}