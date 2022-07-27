class User {
  final String userName;
  final String password;
  final String dep;


  User({
    required this.userName,
    required this.password,
    required this.dep
  });

  User.fromJson(Map<String, dynamic> json)
      : userName = json['username'],
        password = json['password'],
        dep = json['dep'];

  Map<String, dynamic> toJson() => {
    'username': userName,
    'password': password,
    'dep':dep
  };


}