import 'dart:async';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/usecases/view_pdf.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final ViewPdf _viewPdf;

  PdfBloc({@required ViewPdf viewPdf})
      : assert(viewPdf != null),
        _viewPdf = viewPdf,
        super(PdfInitial());

  @override
  Stream<PdfState> mapEventToState(
    PdfEvent event,
  ) async* {
    if (event is ViewPdfEvent) {
      yield Loading();
      final failureOrPdf = await _viewPdf.call(Params(url: event.path));
      yield* _eitherPdfOrErrorState(failureOrPdf);
    }
  }

  Stream<PdfState> _eitherPdfOrErrorState(
    Either<Failure, PDFDocument> failureOrItem,
  ) async* {
    yield failureOrItem.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (pdf) => Loaded(document: pdf),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case PdfFailure:
        return "No cached data!";
      default:
        return 'Bloc';
    }
  }
}
