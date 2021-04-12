import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, ItemModel> itemFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, ItemModel>(k, ItemModel.fromJson(v)));

String itemToJson(Map<String, Item> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ItemModel extends Item {
  ItemModel({
    @required this.title,
    @required this.pdfLinks,
    @required this.htmlTags,
  }) : super(
          title: title,
          pdfLinks: pdfLinks,
          htmlTags: htmlTags,
        );

  final String title;
  final List<PdfLinkModel> pdfLinks;
  final List<HtmlTagModel> htmlTags;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        title: json["title"] == null ? null : json["title"],
        pdfLinks: json["pdfLinks"] == null
            ? null
            : List<PdfLinkModel>.from(
                json["pdfLinks"].map((x) => PdfLinkModel.fromJson(x))),
        htmlTags: json["htmlTags"] == null
            ? null
            : List<HtmlTagModel>.from(
                json["htmlTags"].map((x) => HtmlTagModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "pdfLinks": pdfLinks == null
            ? null
            : List<dynamic>.from(pdfLinks.map((x) => x.toJson())),
        "htmlTags": htmlTags == null
            ? null
            : List<dynamic>.from(htmlTags.map((x) => x.toJson())),
      };
}
