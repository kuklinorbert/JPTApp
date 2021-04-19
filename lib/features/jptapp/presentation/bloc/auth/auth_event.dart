part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChangedEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({@required this.email, @required this.password});

  final String email;
  final String password;

  List<Object> get props => [email, password];
}

class AuthLogoutEvent extends AuthEvent {}
