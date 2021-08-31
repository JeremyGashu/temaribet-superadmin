import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoNo;

  SendOtpEvent({this.phoNo});
}

class AppStartEvent extends AuthEvent {}

class VerifyOtpEvent extends AuthEvent {
  final String otp;

  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends AuthEvent {}

class OtpSendEvent extends AuthEvent {}

class SignUpUserEvent extends AuthEvent {
  final String phoneNo;
  final String role;

  SignUpUserEvent({this.phoneNo, this.role});
  @override
  List<Object> get props => [phoneNo, role];
}

class LoginCompleteEvent extends AuthEvent {
  final User firebaseUser;
  LoginCompleteEvent(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];
}

class LoginExceptionEvent extends AuthEvent {
  final String message;

  LoginExceptionEvent(this.message);
}
