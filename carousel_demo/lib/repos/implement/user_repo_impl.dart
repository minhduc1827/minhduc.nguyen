import 'package:carousel_demo/repos/models/user_model.dart';
import 'package:carousel_demo/repos/remote/remote_provider.dart';

import '../user_repo.dart';

class UserRepoImpl extends UserRepo {
  /// Remote provider
  final RemoteProvider remoteProvider;

  /// Constructor
  UserRepoImpl({this.remoteProvider});

  @override
  Future<UserModel> getUser() {
    return remoteProvider.getUser();
  }
}
