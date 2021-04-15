import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements AuthRepository {}

void main() {
  MockLoginRepository mockLoginRepository;
  Login usecase;
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = Login(mockLoginRepository);
  });

  final tLogin = LoginModel(email: "test@test.com", password: "testpw");
  UserCredential user;

  test('use case call repository', () async {
    //arrange
    when(
      mockLoginRepository.login(any),
    ).thenAnswer((_) async => Right(user));
    //act
    final result = await usecase.call(Params(login: tLogin));
    //assert
    expect(result, Right(user));
    verify(mockLoginRepository.login(tLogin));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
