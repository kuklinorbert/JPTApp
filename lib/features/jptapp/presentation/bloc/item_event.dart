part of 'item_bloc.dart';

@immutable
abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetItemsforApp extends ItemEvent {}
