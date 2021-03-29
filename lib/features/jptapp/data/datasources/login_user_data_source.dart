import 'package:jptapp/features/jptapp/data/models/user_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';

abstract class LoginUser {
  Future<User> login(LoginModel login) async {}
}

class LoginUserImpl implements LoginUser {
  Future<User> login(LoginModel login) async {
    if (login.login == "user" && login.password == "password") {
      return User(id: 'asd332', name: 'admin');
    } else {
      return null;
    }
  }
}
