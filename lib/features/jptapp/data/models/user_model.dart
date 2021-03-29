import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';

class User extends Equatable {
  final String id;
  final String name;
  User({@required this.id, @required this.name});

  @override
  List<Object> get props => [id, name];
}
