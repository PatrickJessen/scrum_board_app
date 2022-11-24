import 'package:scrum_board_app/src/api/ApiAccess.dart';

import '../Board.dart';

class BoardManager {
  ApiAccess access = ApiAccess();

  Future<List<BoardState>> FetchBoard() async {
    return access.FetchBoard();
  }
}
