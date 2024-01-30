import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  bool blockStatus;
  String email;
  String id;
  String name;
  String phone;

  UserModel({
    required this.blockStatus,
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        blockStatus: json["blockStatus"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "blockStatus": blockStatus,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
      };
}
