class UserModel {
  bool? isLoggedIn;
  String? token, refreshToken, phone;

  UserModel({this.isLoggedIn = false, this.token = "", this.refreshToken ="", this.phone});

  
}
    