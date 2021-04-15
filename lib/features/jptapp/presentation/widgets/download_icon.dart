import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/snackbar_show.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadIcon extends StatefulWidget {
  final String pdfRoute;
  final String pdfTitle;

  DownloadIcon({@required this.pdfRoute, @required this.pdfTitle});

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  Directory rootPath;
  ReceivePort _port = ReceivePort();
  String taskId;

  @override
  void initState() {
    FlutterDownloader.registerCallback(downloadCallback);
    _bindBackgroundIsolate();
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          _saveFile(context);
        });
  }

  Future<void> delete() async {
    if (Platform.isIOS) {
      File file = File(rootPath.path + '/download_tasks.sql');
      if (await file.exists()) {
        await file.delete();
      }
    }
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
        String filepath = rootPath.path + "/" + widget.pdfTitle + ".pdf";

        if (!await File(filepath).exists()) {
          if (taskId == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(context, 'start_down'.tr()));
            taskId = await FlutterDownloader.enqueue(
              url: widget.pdfRoute,
              savedDir: rootPath.path,
              fileName: widget.pdfTitle + ".pdf",
              showNotification: true,
              openFileFromNotification: true,
            );
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(buildSnackBar(context, "file_exists".tr()));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar(context, 'no_internet'.tr()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSnackBar(context, 'no_perm_stor'.tr()));
    }
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      setState(() {
        if (status == DownloadTaskStatus.complete) {
          delete();
          ScaffoldMessenger.of(context)
              .showSnackBar(buildSnackBar(context, "down_compl".tr()));
        }
      });
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
}
