import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';

abstract class PdfLinkRepository {
  Future<Either<Failure, PdfLink>> getPdfLink();
}
