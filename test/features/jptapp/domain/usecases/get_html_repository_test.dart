import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';
import 'package:jptapp/features/jptapp/domain/repositories/html_tag_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/get_html_tag.dart';
import 'package:mockito/mockito.dart';

class MockHtmlRepository extends Mock implements HtmlTagRepository {}

void main() {
  GetHtmlTag usecase;
  MockHtmlRepository mockHtmlRepository;
  setUp(() {
    mockHtmlRepository = MockHtmlRepository();
    usecase = GetHtmlTag(mockHtmlRepository);
  });

  final tHtml = HtmlTag(title: 'test1', html: '<test>');

  test(
    'should get html from the repository',
    () async {
      // arrange
      when(mockHtmlRepository.getHtmlTag())
          .thenAnswer((_) async => Right(tHtml));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tHtml));
      verify(mockHtmlRepository.getHtmlTag());
      verifyNoMoreInteractions(mockHtmlRepository);
    },
  );
}
