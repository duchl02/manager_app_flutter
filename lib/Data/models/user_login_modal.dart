class UserLoginModal {
  UserLoginModal({
    required this.user,
    required this.password,
    required this.id,
    required this.position
  });

  final String user;
  final String password;
  final String id;
  final String position;
    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "password": password,
        "position": position,
      };
}
