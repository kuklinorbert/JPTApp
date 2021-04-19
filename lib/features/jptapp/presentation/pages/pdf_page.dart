import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/pdf/pdf_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/download_icon.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/message_display.dart';

import '../../../../injection_container.dart';

class PdfViewPage extends StatefulWidget {
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  PdfLink pdf;
  String pdfRoute;
  String pdfTitle;

  @override
  Widget build(BuildContext context) {
    pdf = ModalRoute.of(context).settings.arguments;
    pdfRoute = pdf.link;
    pdfTitle = pdf.title.replaceAll(" ", "");
    return Scaffold(
        appBar: AppBar(
          actions: [
            DownloadIcon(
                pdfRoute: pdf.link,
                pdfTitle: pdf.title.replaceAll(" ", ""),
                appBarHeight: AppBar().preferredSize.height),
          ],
        ),
        body: Container(
          child: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PdfBloc>(),
      child: Center(
          child: BlocBuilder<PdfBloc, PdfState>(
        cubit: sl<PdfBloc>()..add(ViewPdfEvent(path: pdfRoute)),
        builder: (_, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          } else if (state is Loaded) {
            return PDFViewer(document: state.document);
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          }
        },
      )),
    );
  }
}
