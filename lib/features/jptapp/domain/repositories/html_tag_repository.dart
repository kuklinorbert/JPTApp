import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/entities/html_tag.dart';

abstract class HtmlTagRepository {
  Future<Either<Failure, HtmlTag>> getHtmlTag();
}
