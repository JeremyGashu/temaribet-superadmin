import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:temaribet/core/firebase_services.dart';
import 'package:temaribet/presentations/homepage/pages/parent_homepage.dart';
import 'package:temaribet/presentations/homepage/pages/student_homepage.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';
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
              if(snapshot.data.index == Role.STUDENT.index) {
                return StudentHomePage();
              }
              else if(snapshot.data.index == Role.PARENT.index) {
                return ParentHomePage();
              }
              else{
                FirebaseAuth.instance.signOut();
                return LoginPage();
              }
            }
            return SpinKitRipple(size: 50,color: Colors.grey,);
          },
        ),
      ),
    );
  }
}