import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:jptapp/features/jptapp/domain/usecases/logout.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:easy_localization/easy_localization.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Logout _logout;
  final CheckAuth _checkAuth;

  AuthBloc(
      {@required Login login,
      @required Logout logout,
      @required CheckAuth checkAuth})
      : assert(login != null, logout != null),
        _login = login,
        _logout = logout,
        _checkAuth = checkAuth,
        super(CheckAuthState());

  @override
  AuthState get initialState => CheckAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuthEvent) {
      final result = await _checkAuth.call(NoParams());
      yield* _eitherAuthOrErrorState(result);
    } else if (event is AuthLoginEvent) {
      yield CheckingLoginState();
      final result = await _login.call(Params(
          login: LoginModel(email: event.email, password: event.password)));
      yield* _eitherLoginOrErrorState(result);
    } else if (event is AuthLogoutEvent) {
      final result = await (_logout.call(NoParams()));
      yield* _eitherLogOutOrErrorState(result);
    }
  }

  Stream<AuthState> _eitherAuthOrErrorState(
    Either<Failure, User> failureOrLogin,
  ) async* {
    yield failureOrLogin.fold(
      (failure) => Unauthenticated(),
      (user) {
        return Authenticated();
      },
    );
  }

  Stream<AuthState> _eitherLogOutOrErrorState(
    Either<Failure, void> failureOrLogout,
  ) async* {
    yield failureOrLogout.fold(
      (failure) => ErrorLoggedState(message: _mapFailureToMessage(failure)),
      (user) {
        return Unauthenticated();
      },
    );
  }

  Stream<AuthState> _eitherLoginOrErrorState(
    Either<Failure, UserCredential> failureOrLogin,
  ) async* {
    yield failureOrLogin.fold(
      (failure) => ErrorLoggedState(message: _mapFailureToMessage(failure)),
      (user) {
        return Authenticated();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LogInFailure:
        return 'loginfail'.tr();
      case LogOutFailure:
        return 'logoutfail'.tr();
      case CheckAuthFailure:
        return 'authfail'.tr();
      case NetworkFailure:
        return 'network_fail'.tr();
      default:
        return 'unexp_error'.tr();
    }
  }
}
