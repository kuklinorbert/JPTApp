import 'package:dartz/dartz.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/datasources/download_data_source.dart';
import 'package:jptapp/features/jptapp/domain/repositories/download_repository.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadDataSource downloadDataSource;
  final NetworkInfo networkInfo;

  DownloadRepositoryImpl(
      {@required this.downloadDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, Response>> startDownload(
      String url, String saveDir, String fileName) async {
    if (await networkInfo.isConnected) {
      final file = File(saveDir + "/" + fileName + ".pdf");
      if (!await file.exists()) {
        try {
          final downloadResponse = await downloadDataSource.getDownloadResponse(
              url, saveDir, fileName);
          return Right(downloadResponse);
        } on Exception {
          return Left(DownloadFailure());
        }
      } else {
        return Left(FileExistsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
