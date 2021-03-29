import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tHtmlModel = HtmlTagModel(title: 'test', html: '<test>');

  test(
    'should be a subclass of HtmlTag entity',
    () async {
      // assert
      expect(tHtmlModel, isA<HtmlTag>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('html'));
        // act
        final result = HtmlTagModel.fromJson(jsonMap);
        // assert
        expect(result, tHtmlModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tHtmlModel.toJson();
        // assert
        final expectedMap = {'title': 'test', 'html': '<test>'};
        expect(result, expectedMap);
      },
    );
  });
}
