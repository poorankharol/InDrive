import '../../domain/entity/driver_entity.dart';

class DriverModel extends DriverEntity {
  bool blockStatus;
  CarDetails carDetails;
  String email;
  String id;
  String name;
  String phone;
  String photo;

  DriverModel({
    required this.blockStatus,
    required this.carDetails,
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.photo,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    blockStatus: json["blockStatus"],
    carDetails: CarDetails.fromJson(json["carDetails"]),
    email: json["email"],
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "blockStatus": blockStatus,
    "carDetails": carDetails.toJson(),
    "email": email,
    "id": id,
    "name": name,
    "phone": phone,
    "photo": photo,
  };
}

class CarDetails {
  String carColor;
  String carModel;
  String carNumber;

  CarDetails({
    required this.carColor,
    required this.carModel,
    required this.carNumber,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
    carColor: json["carColor"],
    carModel: json["carModel"],
    carNumber: json["carNumber"],
  );

  Map<String, dynamic> toJson() => {
    "carColor": carColor,
    "carModel": carModel,
    "carNumber": carNumber,
  };
}
