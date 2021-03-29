part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class CheckingLoginState extends LoginState {}

class LoggedState extends LoginState {}

class ErrorLoggedState extends LoginState {}
