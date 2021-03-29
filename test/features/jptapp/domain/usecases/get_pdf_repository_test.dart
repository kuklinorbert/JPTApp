import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';
import 'package:jptapp/features/jptapp/domain/repositories/pdf_link_repository.dart';

import 'package:jptapp/features/jptapp/domain/usecases/get_pdf_link.dart';
import 'package:mockito/mockito.dart';

class MockPdfRepository extends Mock implements PdfLinkRepository {}

void main() {
  GetPdfLink usecase;
  MockPdfRepository mockPdfRepository;
  setUp(() {
    mockPdfRepository = MockPdfRepository();
    usecase = GetPdfLink(mockPdfRepository);
  });

  final tPdfLink = PdfLink(title: 'test', link: 'testtest');

  test(
    'should get pdf from the repository',
    () async {
      // arrange
      when(mockPdfRepository.getPdfLink())
          .thenAnswer((_) async => Right(tPdfLink));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tPdfLink));
      verify(mockPdfRepository.getPdfLink());
      verifyNoMoreInteractions(mockPdfRepository);
    },
  );
}
