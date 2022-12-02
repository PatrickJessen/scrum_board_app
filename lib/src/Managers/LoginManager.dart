import 'package:scrum_board_app/src/User.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';

/**
 * Manager class for Login
 * used to implement any logic (if needed)
 */
class LoginManager {
  ApiAccess api = ApiAccess();

  Future<User> Login(String username, String password) async {
    return await api.Login(username, password);
  }
}
