part of 'pdf_bloc.dart';

abstract class PdfEvent extends Equatable {
  const PdfEvent();

  @override
  List<Object> get props => [];
}

class ViewPdfEvent extends PdfEvent {
  final String path;

  ViewPdfEvent({@required this.path});

  @override
  List<Object> get props => [path];
}
