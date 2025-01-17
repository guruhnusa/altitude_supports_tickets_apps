import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel({
    @JsonKey(name: "user") User? user,
    @JsonKey(name: "token") String? token,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "password") String? password,
    @JsonKey(name: "role") String? role,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "createdAt") String? createdAt,
    @JsonKey(name: "__v") int? v,
    @JsonKey(name: "fcmToken") String? fcmToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
