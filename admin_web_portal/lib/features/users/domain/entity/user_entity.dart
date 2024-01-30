
class UserEntity {
  final String? name;
  final String? email;
  final String? phone;
  final String? id;
  final bool? blockStatus;

  const UserEntity({
    this.name,
    this.email,
    this.phone,
    this.id,
    this.blockStatus,
  });

  UserEntity copyWith({
    String? photo,
    String? name,
    String? email,
    String? phone,
    String? id,
    bool? blockStatus,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      blockStatus: blockStatus ?? this.blockStatus,
    );
  }
}
