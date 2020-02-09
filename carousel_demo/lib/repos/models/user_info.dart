import 'user.dart';

class UserInfo {
  User user;
  String seed;
  String version;

  UserInfo({
    this.user,
    this.seed,
    this.version,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        user: User.fromJson(json["user"]),
        seed: json["seed"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "seed": seed,
        "version": version,
      };
}
