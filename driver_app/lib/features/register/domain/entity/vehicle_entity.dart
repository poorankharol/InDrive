class VehicleEntity {
  final String? carModel;
  final String? carColor;
  final String? carNumber;

  const VehicleEntity({this.carModel, this.carColor, this.carNumber});

  VehicleEntity copyWith({
    String? carModel,
    String? carColor,
    String? carNumber,
  }) {
    return VehicleEntity(
      carModel: carModel ?? this.carModel,
      carColor: carColor ?? this.carColor,
      carNumber: carNumber ?? this.carNumber,
    );
  }
}
