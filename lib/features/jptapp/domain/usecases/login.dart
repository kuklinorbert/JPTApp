import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';

class Login implements UseCase<UserCredential, Params> {
  final AuthRepository loginRepository;

  Login(this.loginRepository);

  @override
  Future<Either<Failure, UserCredential>> call(Params params) async {
    return await loginRepository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginModel login;

  Params({@required this.login});

  @override
  List<Object> get props => [login];
}
