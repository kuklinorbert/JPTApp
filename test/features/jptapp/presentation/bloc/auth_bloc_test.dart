import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:jptapp/features/jptapp/domain/usecases/logout.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth/auth_bloc.dart';
import 'package:mockito/mockito.dart';

class MockLogin extends Mock implements Login {}

class MockLogout extends Mock implements Logout {}

class MockCheckAuth extends Mock implements CheckAuth {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockLogin mockLogin;
  MockLogout mockLogout;
  MockCheckAuth mockCheckAuth;
  MockNetworkInfo mockNetworkInfo;
  AuthBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    mockCheckAuth = MockCheckAuth();
    bloc = AuthBloc(
        login: mockLogin, logout: mockLogout, checkAuth: mockCheckAuth);
  });

  test(
    'initial state should be InitialLoginState',
    () async {
      // assert
      expect(bloc.initialState, equals(CheckAuthState()));
    },
  );

  group('Login', () {
    final tLoginmodel = LoginModel(email: "asd@asd.com", password: "123asd");
    UserCredential user;

    test('should call login', () async {
      // arrange
      when(mockLogin(any)).thenAnswer((_) async => Right(user));
      // act
      bloc.add(AuthLoginEvent(
          email: tLoginmodel.email, password: tLoginmodel.password));
      await untilCalled(mockLogin(any));
      // assert
      verify(mockLogin(Params(login: tLoginmodel)));
    });

    test(
      'should emit [CheckingLoginState, Authenticated] when data are correct',
      () async {
        // arrange
        when(mockLogin(any)).thenAnswer((_) async => Right(user));
        // act
        final expected = [
          CheckingLoginState(),
          Authenticated(),
        ];

        expectLater(bloc, emitsInOrder(expected));

        // assert
        bloc.add(AuthLoginEvent(
            email: tLoginmodel.email, password: tLoginmodel.password));
      },
    );

    test(
      'should emit [CheckingLoginState, ErrorLoggedState] when data are not correct',
      () async {
        // arrange
        when(mockLogin(any)).thenAnswer((_) async => Right(null));
        // act
        bloc.add(AuthLoginEvent(email: 'bademail', password: 'badpw'));
        // assert
        expectLater(
            bloc,
            emitsInOrder([
              CheckingLoginState(),
              ErrorLoggedState(message: "loginfail"),
            ]));
      },
    );
  });
}
