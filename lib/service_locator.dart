import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/data/repositories/auth_repositry.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  /// Blocs
  sl.registerLazySingleton(() => LoginBloc(loginRepository: sl()));

  /// Repositories

  /// data sources

  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepository(firebaseAuth: sl()));

  /// FirebaseAuth instance
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
}
