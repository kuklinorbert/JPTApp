import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/download_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission extends UseCase<PermissionStatus, NoParams> {
  final DownloadRepository downloadRepository;

  CheckPermission(this.downloadRepository);

  @override
  Future<Either<Failure, PermissionStatus>> call(NoParams noParams) async {
    return await downloadRepository.checkPermissions();
  }
}
