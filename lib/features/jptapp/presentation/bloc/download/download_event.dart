part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class StartDownloadEvent extends DownloadEvent {
  final String url;
  final String saveDir;
  final String fileName;

  StartDownloadEvent(
      {@required this.url, @required this.saveDir, @required this.fileName});

  List<Object> get props => [url, saveDir, fileName];
}

class DisposeEvent extends DownloadEvent {}
