import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemModel test = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 5,
          title: Text(test.title),
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
                          title: Text(test.pdfLinks[i].title),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/pdf', arguments: test.pdfLinks[i]);
                          },
                          trailing: Icon(Icons.arrow_forward_ios)),
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
                        trailing: Icon(Icons.arrow_forward_ios),
                        title: Text(test.htmlTags[i].title),
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
