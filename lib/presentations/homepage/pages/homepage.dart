import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';

class HomePage extends StatelessWidget {
  static const String homepageRouteName = 'home_page_route_name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(child: Text('Log Out'),onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(context, LoginPage.loginPageRouterName, (route) => false);
        },),
      ),
    );
  }
}