import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/pdf_link.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/pdf_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/message_display.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/snackbar_show.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import '../../../../injection_container.dart';

class PdfViewPage extends StatelessWidget {
  PdfLink pdf;
  String pdfRoute;
  String pdfTitle;
  Directory rootPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _saveFile(context);
                })
          ],
        ),
        body: Container(
          child: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    pdf = ModalRoute.of(context).settings.arguments;
    pdfRoute = pdf.link;
    pdfTitle = pdf.title.replaceAll(" ", "");
    return BlocProvider(
      create: (_) => sl<PdfBloc>(),
      child: Center(
          child: BlocBuilder<PdfBloc, PdfState>(
        cubit: sl<PdfBloc>()..add(ViewPdfEvent(path: pdfRoute)),
        builder: (_, state) {
          print(state);
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

  Future<void> _saveFile(BuildContext context) async {
    final permission = await Permission.storage.request();
    if (permission.isGranted) {
      if (Platform.isAndroid) {
        rootPath = await DownloadsPathProvider.downloadsDirectory;
      } else {
        rootPath = await getApplicationDocumentsDirectory();
      }
      final network = await DataConnectionChecker().hasConnection;
      if (network) {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar(context, 'start_down'.tr()));
        final taskId = await FlutterDownloader.enqueue(
          url: pdfRoute,
          savedDir: rootPath.path,
          fileName: pdfTitle + ".pdf",
          showNotification: true,
          openFileFromNotification: true,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar(context, 'no_internet'.tr()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSnackBar(context, 'no_perm_stor'.tr()));
    }
  }
}
