import 'package:carousel_demo/repos/flt_exception.dart';
import 'package:carousel_demo/repos/models/user_model.dart';
import 'package:carousel_demo/repos/user_repo.dart';
import 'package:flutter/cupertino.dart';

/*/// Properties use to notify to widget
enum UserBlocProperties {
  ///serverError type
  serverError,

  ///complete type
  complete,
}

class UserBloc extends BaseBloc<UserBlocProperties> {
  final UserRepo userRepo;
  UserModel userModel;

  UserBloc({this.userRepo});

  Future<UserModel> getUser() async {
    try {
      UserModel user = await userRepo.getUser();
      userModel = user;
      notifyListeners(UserBlocProperties.complete);
      return user;
    } on FltException catch (e) {
      String errorMessage = e.message;
      print('UserBloc:getUser error=$errorMessage');
      notifyListeners(UserBlocProperties.serverError);
      return Future.value(null);
    }
  }
}*/
enum UserNotifierProperties {
  ///serverError type
  serverError,

  ///complete type
  complete,
}

class UserNotifier with ChangeNotifier {
  UserNotifierProperties _userNotifierProperties;
  final UserRepo userRepo;
  UserModel _userModel;
  UserNotifier(this.userRepo);
  getUserNotifier() => _userNotifierProperties;
  getUserModel() => _userModel;
  setUserNotifier(UserNotifierProperties userNotifierProperties) =>
      this._userNotifierProperties = userNotifierProperties;

  void notifyServerError() {
    _userNotifierProperties = UserNotifierProperties.serverError;
    notifyListeners();
  }

  void notifyComplete() {
    _userNotifierProperties = UserNotifierProperties.complete;
    notifyListeners();
  }

  Future<UserModel> getUser() async {
    try {
      UserModel user = await userRepo.getUser();
      _userModel = user;
      notifyComplete();
      return user;
    } on FltException catch (e) {
      String errorMessage = e.message;
      print('UserBloc:getUser error=$errorMessage');
      notifyServerError();
      return Future.value(null);
    }
  }
}
