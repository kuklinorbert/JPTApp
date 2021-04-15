import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/data/datasources/pdf_data_source.dart';
import 'package:jptapp/features/jptapp/domain/repositories/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfDataSource pdfDataSource;

  PdfRepositoryImpl({@required this.pdfDataSource});

  @override
  Future<Either<Failure, PDFDocument>> getPdf(String url) async {
    try {
      final pdf = await pdfDataSource.getPdf(url);
      return Right(pdf);
    } on Exception {
      return Left(PdfFailure());
    }
  }
}
