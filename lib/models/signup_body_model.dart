class SignUpBody {
  String name;
  String email;
  String passwordConfirmation;
  String password;
  SignUpBody({
    required this.name,
    required this.email,
    required this.passwordConfirmation,
    required this.password,
  });

  //! creating a function to convert the object to json because the body for the post request has to be in json format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
