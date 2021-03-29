import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';

class PdfLinkModel extends PdfLink {
  PdfLinkModel({@required String title, @required String link})
      : super(title: title, link: link);

  @override
  List<Object> get props => [link, title];

  factory PdfLinkModel.fromJson(Map<String, dynamic> json) => PdfLinkModel(
        title: json["title"] == null ? null : json["title"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "link": link == null ? null : link,
      };
}
