import 'user_info.dart';

class UserModel {
  List<UserInfo> results;

  UserModel({this.results});

  /* UserModel.withError(String errorValue)
      : results = List(),
        error = errorValue;*/

  /*UserModel.fromJson(Map<String, dynamic> json)
      : results =
            (json["results"] as List).map((i) => UserInfo.fromJson(i)).toList();*/

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        results: List<UserInfo>.from(
            json["results"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
