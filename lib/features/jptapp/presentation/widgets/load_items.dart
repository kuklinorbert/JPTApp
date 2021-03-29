import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/item_bloc.dart';

class LoadItems extends StatefulWidget {
  const LoadItems({
    Key key,
  }) : super(key: key);

  @override
  _LoadItemsState createState() => _LoadItemsState();
}

class _LoadItemsState extends State<LoadItems> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<ItemBloc>(context).add(GetItemsforApp());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
