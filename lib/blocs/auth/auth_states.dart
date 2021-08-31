import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}

class OtpSentState extends AuthState {}

class LoadingState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class LoginCompleteState extends AuthState {
  final User _firebaseUser;

  LoginCompleteState(this._firebaseUser);

  User getUser() {
    return _firebaseUser;
  }

  @override
  List<Object> get props => [_firebaseUser];
}

class ExceptionState extends AuthState {
  final String message;

  ExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends AuthState {
  final String message;

  OtpExceptionState({this.message});

  @override
  List<Object> get props => [message];
}
