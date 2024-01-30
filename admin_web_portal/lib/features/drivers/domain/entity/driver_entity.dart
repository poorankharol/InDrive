import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';

class DriverEntity {
  final String? photo;
  final String? name;
  final String? email;
  final String? phone;
  final String? id;
  final bool? blockStatus;
  final CarDetails? carDetails;

  const DriverEntity({
    this.photo,
    this.name,
    this.email,
    this.phone,
    this.id,
    this.blockStatus,
    this.carDetails,
  });

  DriverEntity copyWith({
    String? photo,
    String? name,
    String? email,
    String? phone,
    String? id,
    bool? blockStatus,
    CarDetails? carDetails,
  }) {
    return DriverEntity(
      photo: photo ?? this.photo,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      blockStatus: blockStatus ?? this.blockStatus,
      carDetails: carDetails ?? this.carDetails,
    );
  }
}
