class User {
  String username;
  bool isScrumMaster;

  User(this.username, this.isScrumMaster);

  static User currentUser;
}
