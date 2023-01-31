class UserLoginModal {
  UserLoginModal({
    required this.user,
    required this.password,
    required this.id,
    required this.position,
    required this.name,
    required this.token
  });

  final String user;
  final String password;
  final String id;
  final String position;
  final String token;
  final String name;
    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "password": password,
        "position": position,
        "token": token,
        "name": name,
      };
}
