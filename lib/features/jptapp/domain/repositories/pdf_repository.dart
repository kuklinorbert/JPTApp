import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';

abstract class PdfRepository {
  Future<Either<Failure, PDFDocument>> getPdf(String url);
}
