import 'package:flutter/material.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemModel test = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(test.title),
          textTheme: Theme.of(context).textTheme,
        ),
        body: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: test.pdfLinks.length,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text(test.pdfLinks[i].title,
                              style: Theme.of(context).textTheme.bodyText1),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/pdf', arguments: test.pdfLinks[i]);
                          },
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).accentColor)),
                      Divider()
                    ],
                  );
                }),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: test.htmlTags.length,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).accentColor,
                        ),
                        title: Text(test.htmlTags[i].title,
                            style: Theme.of(context).textTheme.bodyText1),
                        onTap: () {
                          Navigator.of(context).pushNamed('/html',
                              arguments: test.htmlTags[i].html);
                        },
                      ),
                      Divider()
                    ],
                  );
                }),
          ],
        ));
  }
}
