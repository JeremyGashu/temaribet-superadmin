import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class OtpSentState extends LoginState {}

class LoadingState extends LoginState {}

class OtpVerifiedState extends LoginState {}

class LoginCompleteState extends LoginState {
  final User _firebaseUser;

  LoginCompleteState(this._firebaseUser);

  User getUser() {
    return _firebaseUser;
  }

  @override
  List<Object> get props => [_firebaseUser];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  OtpExceptionState({this.message});

  @override
  List<Object> get props => [message];
}
