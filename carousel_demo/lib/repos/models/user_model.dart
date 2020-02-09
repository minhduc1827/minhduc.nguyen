import 'result.dart';

class UserModel {
  List<Result> results;

  UserModel({this.results});

  /* UserModel.withError(String errorValue)
      : results = List(),
        error = errorValue;*/

  /*UserResponse.fromJson(Map<String, dynamic> json)
      : results =
  (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
        error = "";*/
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
