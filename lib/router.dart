import 'package:flutter/material.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/presentations/homepage/pages/parent_homepage.dart';
import 'package:temaribet/presentations/homepage/pages/student_homepage.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';
import 'package:temaribet/presentations/signup/signup_page.dart';
import 'package:temaribet/presentations/splash/welcome_page.dart';

class AppRouter {
  static Route onGeneratedRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case LoginPage.loginPageRouterName:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HomePage.homepageRouteName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case WelcomePage.welcomePageRouteName:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case SignupPage.signUpPageRouteName:
        return MaterialPageRoute(builder: (_) => SignupPage());

      case ParentHomePage.parentHomePageRouteName:
        return MaterialPageRoute(builder: (_) => ParentHomePage());

      case StudentHomePage.studentHomepageRouteName:
        return MaterialPageRoute(builder: (_) => StudentHomePage());

      default:
        return null;
    }
  }
}
