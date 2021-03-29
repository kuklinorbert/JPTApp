import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';

class Item extends Equatable {
  Item({
    @required this.title,
    @required this.pdfLinks,
    @required this.htmlTags,
  });

  final String title;
  final List<PdfLink> pdfLinks;
  final List<HtmlTag> htmlTags;

  @override
  List<Object> get props => [
        title,
        pdfLinks,
        htmlTags,
      ];
}
