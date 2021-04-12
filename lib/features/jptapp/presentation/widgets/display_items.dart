import 'package:flutter/material.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';

class DisplayItems extends StatelessWidget {
  final Map<String, Item> item;

  DisplayItems({@required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: item.length,
        itemBuilder: (_, i) {
          String key = item.keys.elementAt(i);
          return Column(
            children: [
              ListTile(
                title: Text("${item[key].title}",
                    style: Theme.of(context).textTheme.bodyText1),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/details', arguments: item[key]);
                },
              ),
              Divider()
            ],
          );
        });
  }
}
