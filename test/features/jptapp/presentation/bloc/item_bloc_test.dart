import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/domain/usecases/get_item.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/item_bloc.dart';
import 'package:mockito/mockito.dart';

const String SERVER_FAILURE_MESSAGE = 'serverfailure';

class MockGetItem extends Mock implements GetItem {}

void main() {
  ItemBloc bloc;
  MockGetItem mockGetItem;

  setUp(() {
    mockGetItem = MockGetItem();
    bloc = ItemBloc(item: mockGetItem);
  });

  test(
    'initialState should be Empty',
    () async {
      // assert
      expect(bloc.initialState, equals(CheckAuthState()));
    },
  );

  group('GetItemsforApp', () {
    final tItem = {
      'testId': ItemModel(
        title: 'Test',
        pdfLinks: [
          PdfLinkModel(title: 'test', link: 'testtest'),
        ],
        htmlTags: [
          HtmlTagModel(title: 'test', html: 'testtest'),
        ],
      )
    };

    test(
      'should get data from the use case',
      () async {
        // arrange
        when(mockGetItem(any)).thenAnswer((_) async => Right(tItem));
        // act
        bloc.add(GetItemsforApp());
        await untilCalled(mockGetItem(any));
        // assert
        verify(mockGetItem(NoParams()));
      },
    );
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetItem(any)).thenAnswer((_) async => Right(tItem));
        // act
        final expected = [Loading(), Loaded(item: tItem)];
        expectLater(bloc, emitsInOrder(expected));
        // assert
        bloc.add(GetItemsforApp());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetItem(any)).thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
        expectLater(bloc, emitsInOrder(expected));
        // assert
        bloc.add(GetItemsforApp());
      },
    );
  });
}
