import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class LogInFailure extends Failure {}

class LogOutFailure extends Failure {}

class CheckAuthFailure extends Failure {}

class PdfFailure extends Failure {}
