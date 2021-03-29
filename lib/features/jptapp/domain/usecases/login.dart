import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/data/models/user_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';
import 'package:jptapp/features/jptapp/domain/repositories/login_repository.dart';

class Login implements UseCase<bool, Params> {
  final LoginRepository loginRepository;

  Login(this.loginRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await loginRepository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginModel login;

  Params({@required this.login});

  @override
  List<Object> get props => [login];
}
