import 'package:flutter/material.dart';
import 'package:temaribet/presentations/login/pages/login_page.dart';
import 'package:temaribet/presentations/signup/signup_page.dart';


class WelcomePage extends StatelessWidget {
  static const String welcomePageRouteName = 'welcome_page_router_name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red[300], Colors.yellow],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                // Container(
                //   width: 120,
                //   height: 120,
                //   margin: EdgeInsets.only(bottom: 40),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //   ),
                //   child: Image.asset(
                //     "assets/images/sewasew_logo.png",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.loginPageRouterName);
                    },
                    child:
                        Text('LOG IN', style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black54),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ))),
                  ),
                ),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupPage.signUpPageRouteName);
                    },
                    child: Text('SIGN UP', style: TextStyle(color: Colors.black54)),
                    style: ButtonStyle(
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                side: BorderSide(color: Colors.black54, width: 2.0)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
