import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:jptapp/core/error/exceptions.dart';

abstract class PdfDataSource {
  Future<PDFDocument> getPdf(String url);
}

class PdfDataSourceImpl implements PdfDataSource {
  @override
  Future<PDFDocument> getPdf(String url) async {
    final result = await PDFDocument.fromURL(url,
        cacheManager: CacheManager(Config(
          "pdf",
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 3,
        )));
    if (result != null) {
      return result;
    } else {
      throw PdfException();
    }
  }
}
