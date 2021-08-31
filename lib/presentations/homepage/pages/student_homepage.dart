import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temaribet/presentations/splash/welcome_page.dart';

class StudentHomePage extends StatelessWidget {
  static const studentHomepageRouteName = 'student_home_route_name';
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Student'),
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
