import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';

class SuperAdminPage extends StatelessWidget {
  static const superAdminRouteName = 'super_admin_route_name';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text('Superadmin'),
        ),
        TextButton(
          child: Text('Log Out'),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.loginPageRouterName, (route) => false);
          },
        ),
      ],
    );
  }
}
