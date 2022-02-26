class UserModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String gender;
  String dateOfBirth;

  UserModel({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.gender = 'male',
    this.dateOfBirth = '',
  });
}
