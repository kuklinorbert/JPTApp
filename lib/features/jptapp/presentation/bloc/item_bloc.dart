import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/domain/usecases/get_item.dart';
import 'package:meta/meta.dart';
import 'package:easy_localization/easy_localization.dart';

part 'item_event.dart';
part 'item_state.dart';

const String SERVER_FAILURE_MESSAGE = 'serverfailure';
const String CACHE_FAILURE_MESSAGE = 'cachefailure';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItem getItem;

  ItemBloc({@required GetItem item})
      : assert(
          item != null,
        ),
        getItem = item,
        super(Loading());

  @override
  ItemState get initialState => Loading();

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is GetItemsforApp) {
      yield Loading();
      final failureOrItem = await getItem(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrItem);
    }
  }

  Stream<ItemState> _eitherLoadedOrErrorState(
    Either<Failure, Map<String, Item>> failureOrItem,
  ) async* {
    yield failureOrItem.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (item) => Loaded(item: item),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE.tr();
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE.tr();
      default:
        return 'Unexpected error';
    }
  }
}
