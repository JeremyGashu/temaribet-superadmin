import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/data/repositories/auth_repositry.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/presentations/splash/welcome_page.dart';
import 'package:temaribet/router.dart';
import 'package:temaribet/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocatorInit();
  final _loginRepo = sl<AuthRepository>();
  User _user = _loginRepo.getUser();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGeneratedRoute,
        home: _user == null ? WelcomePage() : HomePage(),
        //TODO => check the auth status on the splash page
      ),
    ),
  );
}
