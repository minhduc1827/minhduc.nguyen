import 'location.dart';
import 'name.dart';

class User {
  String gender;
  Name name;
  Location location;
  String email;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String ssn;
  String picture;

  User({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
    this.registered,
    this.dob,
    this.phone,
    this.cell,
    this.ssn,
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json["gender"],
        name: Name.fromJson(json["name"]),
        location: Location.fromJson(json["location"]),
        email: json["email"],
        username: json["username"],
        password: json["password"],
        salt: json["salt"],
        md5: json["md5"],
        sha1: json["sha1"],
        sha256: json["sha256"],
        registered: json["registered"],
        dob: json["dob"],
        phone: json["phone"],
        cell: json["cell"],
        ssn: json["SSN"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "name": name.toJson(),
        "location": location.toJson(),
        "email": email,
        "username": username,
        "password": password,
        "salt": salt,
        "md5": md5,
        "sha1": sha1,
        "sha256": sha256,
        "registered": registered,
        "dob": dob,
        "phone": phone,
        "cell": cell,
        "SSN": ssn,
        "picture": picture,
      };
}
