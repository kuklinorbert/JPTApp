import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';
import 'package:jptapp/features/jptapp/domain/repositories/login_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  MockLoginRepository mockLoginRepository;
  Login usecase;
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = Login(mockLoginRepository);
  });

  final tLogin = LoginModel(login: "login", password: "password");
  test('use case call repository', () async {
    //arrange
    when(
      mockLoginRepository.login(any),
    ).thenAnswer((_) async => Right(true));
    //act
    final result = await usecase.call(Params(login: tLogin));
    //assert
    expect(result, Right(true));
    verify(mockLoginRepository.login(tLogin));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
