import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginModel extends Equatable {
  final String email;
  final String password;

  LoginModel({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
