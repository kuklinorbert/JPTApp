import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/pdf_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';

class ViewPdf extends UseCase<PDFDocument, Params> {
  final PdfRepository repository;

  ViewPdf(this.repository);

  @override
  Future<Either<Failure, PDFDocument>> call(Params params) async {
    return await repository.getPdf(params.url);
  }
}

class Params extends Equatable {
  final String url;

  Params({@required this.url});

  @override
  List<Object> get props => [url];
}
