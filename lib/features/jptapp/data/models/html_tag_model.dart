import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';

class HtmlTagModel extends HtmlTag {
  HtmlTagModel({@required String title, @required String html})
      : super(title: title, html: html);

  @override
  List<Object> get props => [title, html];

  factory HtmlTagModel.fromJson(Map<String, dynamic> json) => HtmlTagModel(
        title: json["title"] == null ? null : json["title"],
        html: json["html"] == null ? null : json["html"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "html": html == null ? null : html,
      };
}
