import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/download/download_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/item/item_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/display_items.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/message_display.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/snackbar_show.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../injection_container.dart';

class ItemsPage extends StatelessWidget {
  Map<String, Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _checkPermissions(context);
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      appBar: AppBar(
        title: Text('greet'.tr()),
        textTheme: Theme.of(context).textTheme,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              })
        ],
      ),
      body: Container(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocListener(
        cubit: BlocProvider.of<DownloadBloc>(context),
        listener: (context, state) {
          if (state is DownloadComplete) {
            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(context, "down_compl".tr()));
          } else if (state is DownloadError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(context, state.message));
          }
        },
        child: Center(
          child: BlocBuilder<ItemBloc, ItemState>(
            cubit: sl<ItemBloc>()..add(GetItemsforApp()),
            builder: (context, state) {
              if (state is Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is Loaded) {
                items = state.item;
                return DisplayItems(item: state.item);
              } else if (state is Error) {
                return MessageDisplay(message: state.message);
              }
            },
          ),
        ));
  }

  void _checkPermissions(BuildContext context) async {
    final permission = await Permission.camera.request();

    if (permission.isGranted) {
      Navigator.of(context).pushNamed('/qr-scan', arguments: items);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSnackBar(context, "no_perm_cam".tr()));
    }
  }
}
