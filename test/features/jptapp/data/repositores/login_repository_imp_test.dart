import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/data/datasources/login_user_data_source.dart';
import 'package:jptapp/features/jptapp/data/models/user_model.dart';
import 'package:jptapp/features/jptapp/data/repositories/auth_repository_impl.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:mockito/mockito.dart';

class MockLoginUser extends Mock implements LoginUser {}

void main() {
  MockLoginUser mockLoginUser;
  AuthRepositoryImpl loginRepositoryImpl;

  setUp(() {
    mockLoginUser = MockLoginUser();
    loginRepositoryImpl = AuthRepositoryImpl(mockLoginUser);
  });

  group('Login User', () {
    final LoginModel tLogin = LoginModel(login: "user1", password: "password");
    final LoginModel tLoginCorrect =
        LoginModel(login: "user", password: "password");
    final User user = User(id: '1', name: "admin");
    test('Should call datasource', () {
      //arrange
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => user);
      //act
      loginRepositoryImpl.login(tLogin);
      //assert
      verify(mockLoginUser.login(tLogin));
    });

    test('Should return true if login correct', () async {
      //arrange
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => user);
      //act
      final result = await loginRepositoryImpl.login(tLoginCorrect);
      //assert
      expect(result, Right(true));
    });

    test('Should return false if login is not correct', () async {
      //arrange
      when(mockLoginUser.login(tLoginCorrect)).thenAnswer((_) async => null);
      //act
      final result = await loginRepositoryImpl.login(tLogin);
      //assert
      expect(result, Right(false));
    });
  });
}
