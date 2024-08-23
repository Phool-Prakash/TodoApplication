class User {
  final String userName;
  String? token;
  final String refreshToken;

  User({
    required this.userName,
    this.token,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['username'],
        ///This is not required
        token: json['token'],
        refreshToken: json['refreshToken']);
  }

  void updateToken(String newToken) {
    token = newToken;
  }
}
