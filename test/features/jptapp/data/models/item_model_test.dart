import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tItemModel = ItemModel(
    title: 'Test',
    pdfLinks: [
      PdfLinkModel(title: 'test', link: 'testtest'),
    ],
    htmlTags: [
      HtmlTagModel(title: 'test', html: 'testtest'),
    ],
  );

  test(
    'should be a subclass of Item entity',
    () async {
      // assert
      expect(tItemModel, isA<Item>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('item'));
        //print(jsonMap);
        // act
        final result = ItemModel.fromJson(jsonMap['testid']);
        //print(result.title);
        //print(tItemModel.title);
        // assert
        expect(result, tItemModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tItemModel.toJson();
        // assert
        final expectedMap = ItemModel(
          title: 'Test',
          pdfLinks: [
            PdfLinkModel(link: 'testtest', title: 'test'),
          ],
          htmlTags: [
            HtmlTagModel(html: 'testtest', title: 'test'),
          ],
        ).toJson();
        expect(result, expectedMap);
      },
    );
  });
}
