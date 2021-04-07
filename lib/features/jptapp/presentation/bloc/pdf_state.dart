part of 'pdf_bloc.dart';

abstract class PdfState extends Equatable {
  const PdfState();

  @override
  List<Object> get props => [];
}

class PdfInitial extends PdfState {
  @override
  List<Object> get props => [];
}

class Loading extends PdfState {}

class Loaded extends PdfState {
  final PDFDocument document;

  Loaded({@required this.document});

  @override
  List<Object> get props => [document];
}

class Error extends PdfState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
