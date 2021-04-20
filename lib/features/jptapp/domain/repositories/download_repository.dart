import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class DownloadRepository {
  Future<Either<Failure, Response>> startDownload(
      String url, String saveDir, String fileName);
  Future<Either<Failure, PermissionStatus>> checkPermissions();
}
