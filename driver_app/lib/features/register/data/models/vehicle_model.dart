import '../../domain/entity/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  final String? carModel;
  final String? carColor;
  final String? carNumber;

  const VehicleModel({
    this.carModel,
    this.carColor,
    this.carNumber,
  }) : super(
          carModel: carModel,
          carColor: carColor,
          carNumber: carNumber,
        );

  Map<String, dynamic> toDocument() => {
        "carModel": carModel,
        "carColor": carColor,
        "carNumber": carNumber,
      };
}
