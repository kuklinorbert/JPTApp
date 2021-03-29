import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';

import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';
import 'package:jptapp/features/jptapp/domain/repositories/pdf_link_repository.dart';

class GetPdfLink extends UseCase<PdfLink, NoParams> {
  final PdfLinkRepository repository;

  GetPdfLink(this.repository);

  @override
  Future<Either<Failure, PdfLink>> call(NoParams) async {
    return await repository.getPdfLink();
  }
}
