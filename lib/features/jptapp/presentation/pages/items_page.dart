import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/item_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/display_items.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/load_items.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/message_display.dart';

import '../../../../injection_container.dart';

class ItemsPage extends StatelessWidget {
  Map<String, Item> teszt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/qr-scan', arguments: teszt);
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      appBar: AppBar(
        title: Text('msg'.tr()),
        textTheme: Theme.of(context).textTheme,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              })
        ],
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ItemBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<ItemBloc, ItemState>(
                cubit: sl<ItemBloc>()..getItem,
                builder: (_, state) {
                  if (state is Empty) {
                    return LoadItems();
                  } else if (state is Loading) {
                    return CircularProgressIndicator();
                  } else if (state is Loaded) {
                    teszt = state.item;
                    return DisplayItems(item: state.item);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
