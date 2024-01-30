import 'package:driver_app/features/register/domain/entity/driver_entity.dart';
import 'package:driver_app/features/register/domain/entity/vehicle_entity.dart';

class DriverModel extends DriverEntity {
  final String? photo;
  final String? name;
  final String? email;
  final String? phone;
  final String? id;
  final bool? blockStatus;
  final Map? vehicleEntity;

  const DriverModel({
    this.photo,
    this.name,
    this.email,
    this.phone,
    this.id,
    this.blockStatus,
    this.vehicleEntity,
  }) : super(
          photo: photo,
          name: name,
          email: email,
          phone: photo,
          id: id,
          blockStatus: blockStatus,
          vehicleEntity: vehicleEntity,
        );

  Map<String, dynamic> toDocument() => {
        "photo": photo,
        "name": name,
        "email": email,
        "phone": phone,
        "id": id,
        "blockStatus": blockStatus,
        "carDetails": vehicleEntity,
      };
}
