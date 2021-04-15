import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PdfLink extends Equatable {
  final String title;
  final String link;

  PdfLink({@required this.title, @required this.link});

  @override
  List<Object> get props => [title, link];
}
