import 'package:flutter/material.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemModel items = ModalRoute.of(context).settings.arguments;
    List<PdfLinkModel> pdfs = items.pdfLinks;
    List<HtmlTagModel> htmls = items.htmlTags;
    return Scaffold(
      appBar: AppBar(
        title: Text(items.title),
        textTheme: Theme.of(context).textTheme,
      ),
      body: ListView(
        children: [
          pdfs == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: pdfs.length,
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        ListTile(
                            title: Text(pdfs[i].title,
                                style: Theme.of(context).textTheme.bodyText1),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/pdf', arguments: pdfs[i]);
                            },
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: Theme.of(context).accentColor)),
                        Divider()
                      ],
                    );
                  }),
          htmls == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: htmls.length == null ? 0 : htmls.length,
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(htmls[i].title,
                              style: Theme.of(context).textTheme.bodyText1),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/html', arguments: htmls[i].html);
                          },
                        ),
                        Divider()
                      ],
                    );
                  }),
        ],
      ),
    );
  }
}
