import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temaribet/core/firebase_services.dart';
import 'package:temaribet/presentations/homepage/pages/superadmin_page.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';
import 'package:temaribet/presentations/login/widgets/loading_indicator.dart';
import 'package:temaribet/utils/utils.dart';

class HomePage extends StatelessWidget {
  static const String homepageRouteName = 'home_page_route_name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Role>(
          future: getUserRoleByPhoneNumber(phone: getUser().phoneNumber),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data.index == Role.SUPERADMIN.index) {
                return SuperAdminPage();
              }
              else{
                FirebaseAuth.instance.signOut();
                return LoginPage();
              }
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}