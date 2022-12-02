class User {
  String username;
  bool isScrumMaster;

  User(this.username, this.isScrumMaster);

  // Current logged in user wich can be called from anywhere
  static User currentUser;
}
