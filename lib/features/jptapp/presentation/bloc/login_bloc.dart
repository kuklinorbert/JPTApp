import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:jptapp/features/jptapp/presentation/dto/login_dto.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUseCase;
  LoginBloc(this.loginUseCase) : super(InitialLoginState());

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckLoginEvent) {
      yield CheckingLoginState();
      final result = await loginUseCase.call(Params(
          login: LoginModel(
              login: event.login.username, password: event.login.password)));
      yield result.fold((failure) => ErrorLoggedState(),
          (value) => (value) ? LoggedState() : ErrorLoggedState());
    }
  }
}
