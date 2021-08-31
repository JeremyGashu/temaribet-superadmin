import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temaribet/presentations/splash/welcome_page.dart';

class ParentHomePage extends StatelessWidget {
  static const String parentHomePageRouteName = 'parent_homepage_route_name';

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Parent'),
          ),
          TextButton(
            child: Text('Log Out'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomePage.welcomePageRouteName, (route) => false);
            },
          ),
        ],
      );
  }
}
