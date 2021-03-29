import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginModel extends Equatable {
  final String login;
  final String password;

  LoginModel({@required this.login, @required this.password});

  @override
  List<Object> get props => [login, password];
}
