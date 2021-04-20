import 'dart:io';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/download/download_bloc.dart';
import 'package:path_provider/path_provider.dart';

class DownloadIcon extends StatefulWidget {
  final String pdfRoute;
  final String pdfTitle;
  final double appBarHeight;

  DownloadIcon(
      {@required this.pdfRoute,
      @required this.pdfTitle,
      @required this.appBarHeight});

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  Directory rootPath;
  DownloadBloc downloadBloc;

  @override
  void initState() {
    downloadBloc = BlocProvider.of<DownloadBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setRootPath() async {
    if (Platform.isAndroid) {
      rootPath = await DownloadsPathProvider.downloadsDirectory;
    } else {
      rootPath = await getApplicationDocumentsDirectory();
    }
  }

  @override
  Widget build(BuildContext context) {
    setRootPath();
    return BlocListener(
      cubit: downloadBloc,
      listener: (context, state) {
        if (state is PermissionGrantedState) {
          downloadBloc.add(StartDownloadEvent(
              url: widget.pdfRoute,
              saveDir: rootPath.path,
              fileName: widget.pdfTitle.replaceAll(" ", "")));
        } else if (state is DownloadError) {
          downloadBloc.add(InitialEvent());
        }
      },
      child: BlocBuilder<DownloadBloc, DownloadState>(
          cubit: downloadBloc,
          builder: (BuildContext context, state) {
            if (state is Downloading) {
              return Container(
                  margin: EdgeInsets.only(right: widget.appBarHeight / 4),
                  child: Center(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: SizedBox(
                      height: widget.appBarHeight / 2,
                      width: widget.appBarHeight / 2,
                      child: CircularProgressIndicator(),
                    ),
                  ));
            } else
              return buildIconButton();
          }),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          downloadBloc.add(CheckPermissionEvent());
        });
  }
}
