import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';
import 'package:jptapp/features/jptapp/domain/repositories/html_tag_repository.dart';

class GetHtmlTag extends UseCase<HtmlTag, NoParams> {
  final HtmlTagRepository repository;

  GetHtmlTag(this.repository);

  @override
  Future<Either<Failure, HtmlTag>> call(NoParams) async {
    return await repository.getHtmlTag();
  }
}
