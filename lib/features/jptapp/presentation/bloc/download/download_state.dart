part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadInitial extends DownloadState {}

class Downloading extends DownloadState {}

class DownloadComplete extends DownloadState {}

class DownloadError extends DownloadState {
  final String message;

  DownloadError({@required this.message});

  @override
  List<Object> get props => [message];
}

class PermissionGrantedState extends DownloadState {}
