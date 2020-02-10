import 'package:carousel_demo/repos/flt_exception.dart';
import 'package:carousel_demo/repos/models/user_model.dart';
import 'package:carousel_demo/repos/user_repo.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

/// Properties use to notify to widget
enum UserBlocProperties {
  ///serverError type
  serverError,

  ///complete type
  complete,
}

class UserBloc extends PropertyChangeNotifier<UserBlocProperties> {
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
}
