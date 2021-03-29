import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class HtmlTag extends Equatable {
  String title;
  String html;

  HtmlTag({@required this.title, @required this.html});

  @override
  List<Object> get props => [title, html];
}
