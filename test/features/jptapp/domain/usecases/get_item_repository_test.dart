import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/repositories/item_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/get_item.dart';
import 'package:mockito/mockito.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  GetItem usecase;
  MockItemRepository mockItemRepository;
  setUp(() {
    mockItemRepository = MockItemRepository();
    usecase = GetItem(mockItemRepository);
  });

  final tItem = {
    'testId': ItemModel(
      title: 'Test',
      pdfLinks: [
        PdfLinkModel(title: 'test', link: 'testtest'),
      ],
      htmlTags: [
        HtmlTagModel(title: 'test', html: 'testtest'),
      ],
    )
  };

  test(
    'should get item from the repository',
    () async {
      //arrange
      when(mockItemRepository.getItem()).thenAnswer((_) async => Right(tItem));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, Right(tItem));
      verify(mockItemRepository.getItem());
      verifyNoMoreInteractions(mockItemRepository);
    },
  );
}
