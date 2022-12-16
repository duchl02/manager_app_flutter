class UserModal {
  UserModal({
    this.id,
    this.name,
    this.birthday,
    this.address,
    this.idNumber,
    this.position,
    this.email,
    this.phoneNumber,
    this.createAt,
    this.updateAt,
  });

  final String? name;
  final String? id;
  final DateTime? birthday;
  final String? address;
  final String? idNumber;
  final String? phoneNumber;
  final String? position;
  final String? email;
  final DateTime? createAt;
  final DateTime? updateAt;
}
