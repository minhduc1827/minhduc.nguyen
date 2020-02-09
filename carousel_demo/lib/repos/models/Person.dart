import 'Result.dart';

class Person {
  List<Result> results;

  Person({
    this.results,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
