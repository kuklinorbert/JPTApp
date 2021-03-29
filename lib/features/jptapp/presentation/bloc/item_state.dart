part of 'item_bloc.dart';

@immutable
abstract class ItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ItemState {}

class Loading extends ItemState {}

class Loaded extends ItemState {
  final Map<String, Item> item;

  Loaded({@required this.item});

  @override
  List<Object> get props => [item];
}

class Error extends ItemState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
