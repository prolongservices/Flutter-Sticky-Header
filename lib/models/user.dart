import 'package:intl/intl.dart';

class User {
  final String id;
  final String picture;
  final int age;
  final String name;
  final String company;
  final String email;
  final DateTime registered;

  User(
      {this.id,
      this.picture,
      this.age,
      this.email,
      this.name,
      this.company,
      this.registered});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        picture = json['picture'],
        age = json['age'],
        email = json['email'],
        name = json['name'],
        company = json['company'],
        registered = _toDateTime(json['registered']);

  static DateTime _toDateTime(String dateTime) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").parseUtc(dateTime);
  }
}
