class SignUpModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  SignUpModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}