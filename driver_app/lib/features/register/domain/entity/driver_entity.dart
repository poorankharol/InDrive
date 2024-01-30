import 'package:driver_app/features/register/domain/entity/vehicle_entity.dart';

class DriverEntity {
  final String? photo;
  final String? name;
  final String? email;
  final String? phone;
  final String? id;
  final bool? blockStatus;
  final Map? vehicleEntity;

  const DriverEntity({
    this.photo,
    this.name,
    this.email,
    this.phone,
    this.id,
    this.blockStatus,
    this.vehicleEntity,
  });

  DriverEntity copyWith({
    String? photo,
    String? name,
    String? email,
    String? phone,
    String? id,
    bool? blockStatus,
    Map? vehicleEntity,
  }) {
    return DriverEntity(
      photo: photo ?? this.photo,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      blockStatus: blockStatus ?? this.blockStatus,
      vehicleEntity: vehicleEntity ?? this.vehicleEntity,
    );
  }
}
