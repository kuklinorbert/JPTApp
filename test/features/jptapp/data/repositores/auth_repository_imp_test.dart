import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/data/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl authRepositoryImpl;
  MockFirebaseAuth mockFirebaseAuth;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockNetworkInfo = MockNetworkInfo();
    authRepositoryImpl = AuthRepositoryImpl(
        firebaseAuth: mockFirebaseAuth, networkInfo: mockNetworkInfo);
  });

  test(
    'should check if the device is online',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      authRepositoryImpl.login(LoginModel(email: "bad", password: "login"));
      // assert
      verify(mockNetworkInfo.isConnected);
    },
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('Login User', () {
    final LoginModel tLogin = LoginModel(email: "bad", password: "login");
    final LoginModel tLoginCorrect =
        LoginModel(email: "test@test.com", password: "testpw");
    Future<Either<Failure, UserCredential>> user;

    runTestsOnline(() {
      test('Should return true if auth correct', () async {
        //arrange
        when(authRepositoryImpl.login(tLoginCorrect))
            .thenAnswer((_) async => user);
        //act
        final result = await authRepositoryImpl.login(tLoginCorrect);
        print(result);
        //assert
        expect(result, Right(tLoginCorrect));
      });

      test('Should return false if auth is not correct', () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(authRepositoryImpl.login(tLoginCorrect))
            .thenAnswer((_) async => null);
        //act
        final result = await authRepositoryImpl.login(tLogin);
        //assert
        expect(result, Right(false));
      });
    });
  });
}
