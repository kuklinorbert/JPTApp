import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPdfLinkModel = PdfLinkModel(title: 'test', link: 'testtest');

  test(
    'should be a subclass of PdfLink entity',
    () async {
      // assert
      expect(tPdfLinkModel, isA<PdfLink>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('pdf'));
        // act
        final result = PdfLinkModel.fromJson(jsonMap);
        // assert
        expect(result, tPdfLinkModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tPdfLinkModel.toJson();
        // assert
        final expectedMap = {'title': 'test', 'link': 'testtest'};
        expect(result, expectedMap);
      },
    );
  });
}
