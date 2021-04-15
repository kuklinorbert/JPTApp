import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:mockito/mockito.dart';

class MockCheckAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockCheckAuthRepository mockCheckAuthRepository;
  CheckAuth usecase;
  setUp(() {
    mockCheckAuthRepository = MockCheckAuthRepository();
    usecase = CheckAuth(mockCheckAuthRepository);
  });

  User user;

  test('use case call repository', () async {
    //arrange
    when(
      MockCheckAuthRepository().checkAuth(),
    ).thenAnswer((_) async => Right(user));
    //act
    final result = await usecase.call(NoParams());
    //assert
    expect(result, Right(user));
    verify(mockCheckAuthRepository.checkAuth());
    verifyNoMoreInteractions(mockCheckAuthRepository);
  });
}
