class UserModel {
  bool? isLoggedIn;
  String? token, refreshToken;

  UserModel({this.isLoggedIn = false, this.token = "", this.refreshToken =""});
}
    