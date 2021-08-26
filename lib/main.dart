import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/data/repositories/auth_repositry.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/router.dart';
import 'package:temaribet/service_locator.dart';

import 'presentations/login/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocatorInit();
  final _loginRepo = sl<LoginRepository>();
  User _user = _loginRepo.getUser();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGeneratedRoute,
        home: _user == null ? LoginPage() : HomePage(),
      ),
    ),
  );
}
