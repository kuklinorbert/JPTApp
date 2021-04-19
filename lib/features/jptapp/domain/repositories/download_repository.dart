import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jptapp/core/error/failure.dart';

abstract class DownloadRepository {
  Future<Either<Failure, Response>> startDownload(
      String url, String saveDir, String fileName);
}
