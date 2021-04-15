import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/logout.dart';
import 'package:mockito/mockito.dart';

class MockLogoutRepository extends Mock implements AuthRepository {}

void main() {
  MockLogoutRepository mockLoginRepository;
  Logout usecase;
  setUp(() {
    mockLoginRepository = MockLogoutRepository();
    usecase = Logout(mockLoginRepository);
  });

  test('use case call repository', () async {
    //arrange
    when(
      mockLoginRepository.logout(),
    ).thenAnswer((_) async => Right(null));
    //act
    final result = await usecase.call(NoParams());
    //assert
    expect(result, Right(null));
    verify(mockLoginRepository.logout());
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
