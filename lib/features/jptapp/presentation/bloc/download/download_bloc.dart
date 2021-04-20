import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_permission.dart';
import 'package:jptapp/features/jptapp/domain/usecases/start_download.dart';
import 'package:permission_handler/permission_handler.dart';

part 'download_event.dart';
part 'download_state.dart';

enum DownloadStatus { Downloading, DownloadComplete, DownloadError }

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final StartDownload _startDownload;
  final CheckPermission _checkPermission;

  DownloadBloc(
      {@required StartDownload startDownload,
      @required CheckPermission checkPermission})
      : assert(startDownload != null, checkPermission != null),
        _startDownload = startDownload,
        _checkPermission = checkPermission,
        super(DownloadInitial());

  @override
  Stream<DownloadState> mapEventToState(
    DownloadEvent event,
  ) async* {
    if (event is CheckPermissionEvent) {
      final perm = await _checkPermission.call(NoParams());
      yield* _eitherPermissionOrError(perm);
    } else if (event is StartDownloadEvent) {
      yield Downloading();
      final result = await _startDownload.call(Params(
          url: event.url, saveDir: event.saveDir, fileName: event.fileName));
      yield* _eitherDownloadOrErrorState(result);
    } else if (event is InitialEvent) {
      yield DownloadInitial();
    }
  }

  Stream<DownloadState> _eitherPermissionOrError(
    Either<Failure, PermissionStatus> permissionOrDownload,
  ) async* {
    yield permissionOrDownload.fold(
      (failure) => DownloadError(message: _mapFailureToMessage(failure)),
      (permission) {
        return PermissionGrantedState();
      },
    );
  }

  Stream<DownloadState> _eitherDownloadOrErrorState(
    Either<Failure, Response> failureOrDownload,
  ) async* {
    yield failureOrDownload.fold(
      (failure) => DownloadError(message: _mapFailureToMessage(failure)),
      (response) {
        return DownloadComplete();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'network_fail'.tr();
      case DownloadFailure:
        return 'down_fail'.tr();
      case FileExistsFailure:
        return 'file_exists'.tr();
      case PermissionFailure:
        return 'no_perm_stor'.tr();
      default:
        return 'unexp_error'.tr();
    }
  }
}
