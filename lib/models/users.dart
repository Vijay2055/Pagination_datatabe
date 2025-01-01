import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Users {
  Users(
      {required this.name,
      required this.age,
      required this.mobile,
      this.fileUrl,
      required this.isAccepted})
      : id = uuid.v4();

  final String id;
  final String name;
  final int age;
  final String mobile;
  String? fileUrl;
  bool isAccepted;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        name: json['name'],
        age: json['age'],
        mobile: json['mobile'],
        fileUrl: json['fileUri'],
        isAccepted: json['isAccepted']);
  }
}



