import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/usecases/start_download.dart';

part 'download_event.dart';
part 'download_state.dart';

enum DownloadStatus { Downloading, DownloadComplete, DownloadError }

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final StartDownload _startDownload;

  DownloadBloc({@required StartDownload startDownload})
      : assert(startDownload != null),
        _startDownload = startDownload,
        super(DownloadInitial());

  @override
  Stream<DownloadState> mapEventToState(
    DownloadEvent event,
  ) async* {
    if (event is StartDownloadEvent) {
      yield Downloading();
      final result = await _startDownload.call(Params(
          url: event.url, saveDir: event.saveDir, fileName: event.fileName));
      yield* _eitherDownloadOrErrorState(result);
    } else if (event is DisposeEvent) {
      yield DownloadInitial();
    }
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
      default:
        return 'unexp_error'.tr();
    }
  }
}
