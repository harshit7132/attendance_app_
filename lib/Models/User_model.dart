class UserModel {
  String? id;
  String? username;
  String? password;
  String? email;
  String? img;

  UserModel(
      {required this.email,
      required this.password,
      required this.username,
      this.img,
      this.id});

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map["Id"];
    username = map["UserName"];
    email = map["E-mail"];
    password = map["Password"];
    img = map["Image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": id,
      "UserName": username,
      "E-mail": email,
      "Password": password,
      "Image": img
    };
  }
}
