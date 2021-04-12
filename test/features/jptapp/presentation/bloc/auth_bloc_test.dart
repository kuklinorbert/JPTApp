// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:jptapp/core/error/failure.dart';
// import 'package:jptapp/features/jptapp/data/models/login_model.dart';
// import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
// import 'package:mockito/mockito.dart';

// class MockLogin extends Mock implements Login {}

// void main() {
//   MockLogin mockLogin;
//   LoginBloc bloc;

//   setUp(() {
//     mockLogin = MockLogin();
//     bloc = LoginBloc(mockLogin);
//   });

//   test(
//     'initial state should be InitialLoginState',
//     () async {
//       // assert
//       expect(bloc.initialState, equals(InitialLoginState()));
//     },
//   );

//   group('Login', () {
//     final tLoginDTO = LoginDTO(username: "user", password: "password");

//     test('should call add movie', () async {
//       // arrange
//       when(mockLogin(any)).thenAnswer((_) async => Right(true));
//       // act
//       bloc.add(CheckLoginEvent(login: tLoginDTO));
//       await untilCalled(mockLogin(any));
//       // assert
//       verify(mockLogin(Params(
//           login: LoginModel(
//         login: tLoginDTO.username,
//         password: tLoginDTO.password,
//       ))));
//     });

//     test(
//       'should emit [Checking, Logged] when data are correct',
//       () async {
//         // arrange
//         when(mockLogin(any)).thenAnswer((_) async => Right(true));
//         // act
//         final expected = [
//           CheckingLoginState(),
//           LoggedState(),
//         ];

//         expectLater(bloc, emitsInOrder(expected));

//         // assert
//         bloc.add(CheckLoginEvent(login: tLoginDTO));
//       },
//     );

//     test(
//       'should emit [Checking, Error] when data are not correct',
//       () async {
//         // arrange
//         when(mockLogin(any)).thenAnswer((_) async => Right(false));
//         // act
//         bloc.add(CheckLoginEvent(login: tLoginDTO));
//         // assert
//         expectLater(
//             bloc,
//             emitsInOrder([
//               CheckingLoginState(),
//               ErrorLoggedState(),
//             ]));
//       },
//     );

//     test(
//       'should emit [Checking, Error] when server error',
//       () async {
//         // arrange
//         when(mockLogin(any)).thenAnswer((_) async => Left(ServerFailure()));
//         // act
//         bloc.add(CheckLoginEvent(login: tLoginDTO));
//         // assert
//         expectLater(
//             bloc,
//             emitsInOrder([
//               CheckingLoginState(),
//               ErrorLoggedState(),
//             ]));
//       },
//     );
//   });
// }
