import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String id;
  final String email;

  const User({@required this.id, @required this.email});

  @override
  List<Object> get props => [id, email];

  static const empty = const User(email: '', id: '');
}
