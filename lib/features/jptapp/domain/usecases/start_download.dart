import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/download_repository.dart';

class StartDownload extends UseCase<Response, Params> {
  final DownloadRepository repository;

  StartDownload(this.repository);

  @override
  Future<Either<Failure, Response>> call(Params params) async {
    return await repository.startDownload(
        params.url, params.saveDir, params.fileName);
  }
}

class Params extends Equatable {
  final String url;
  final String saveDir;
  final String fileName;

  Params({@required this.url, @required this.saveDir, @required this.fileName});

  @override
  List<Object> get props => [url, saveDir, fileName];
}
