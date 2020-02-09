import 'models/user_model.dart';

abstract class UserRepo {
  Future<UserModel> getUser();
}
