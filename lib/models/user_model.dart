//! creating a user model so we can display user data
class UserModel {
  int id;
  String name;
  String email;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  //! creating another factory model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
    );
  }
}
