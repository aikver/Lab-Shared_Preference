// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String username;
    String password;
    String name;
    String role;

    UserModel({
        required this.id,
        required this.username,
        required this.password,
        required this.name,
        required this.role,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "name": name,
        "role": role,
    };
}
