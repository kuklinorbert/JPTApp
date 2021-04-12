import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final htmlData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Html(
        data: htmlData,
      ),
    );
  }
}
