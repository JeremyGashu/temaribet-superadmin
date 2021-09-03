import 'dart:async';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:temaribet/blocs/auth/auth_event.dart';
import 'package:temaribet/core/firebase_services.dart';
import 'package:temaribet/data/repositories/auth_repositry.dart';
import 'package:bloc/bloc.dart';
import 'package:temaribet/utils/utils.dart';

import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository loginRepository;
  StreamSubscription streamSubscription;
  String selectedRole;

  String verId = '';
  AuthBloc({@required this.loginRepository})
      : assert(loginRepository != null),
        super(LoginInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      bool userRegistered = await userExists(phoneNumber: event.phoNo);
      Role role = await getUserRoleByPhoneNumber(phone: event.phoNo);
      if (!userRegistered) {
        yield ExceptionState(
            message: 'Unknown Phone Number');
        return;
      }
      
      else if(userRegistered && role.index == Role.SUPERADMIN.index) {
        streamSubscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
      }

      else{
        yield ExceptionState(
            message: 'Unknown Phone Number');
        return;
      }
    }else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      try {

        yield LoginCompleteState(event.firebaseUser);
      } catch (e) {
        yield ExceptionState(
            message: 'Error on Login!');
      }
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result =
            await loginRepository.verifyAndLogin(verId, event.otp);
        if (result.user != null) {

          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    }
  }

  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    streamSubscription.cancel();
    super.close();
  }

  Stream<AuthEvent> sendOtp(String phoNo) async* {
    StreamController<AuthEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      loginRepository.getUser();
      User _user = loginRepository.getUser();

      if (_user == null) {
      } else {
        eventStream.add(LoginCompleteEvent(_user));
        eventStream.close();
      }
    };
    final phoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String id, [int forceResent]) {
      this.verId = id;
      eventStream.add(OtpSendEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String id) {
      this.verId = id;
      // eventStream.add(VerifyOtpEvent(otp: id));
      eventStream.close();
    };

    final onErrorHandler = (error, s) {
      eventStream.add(LoginExceptionEvent(error.message));
    };

    await loginRepository.sendOtp(
        phoNo,
        Duration(seconds: 60),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout, );

    yield* eventStream.stream;
  }
}
