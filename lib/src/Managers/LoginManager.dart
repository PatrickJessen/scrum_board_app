

import 'package:scrum_board_app/src/User.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';

class LoginManager
{
  ApiAccess api = ApiAccess();

  Future<User> Login(String username, String password) async {
    return await api.Login(username, password);
  }
}