import 'package:scrum_board_app/src/api/ApiAccess.dart';

import '../Board.dart';

class BoardManager {
  ApiAccess access = ApiAccess();

  Future<Board> FetchBoard(String boardTitle) async {
    return access.FetchBoard(boardTitle);
  }

  Future<List<String>> FetchSprintNames() async {
    return await access.FetchAllSprintNames();
  }

  List<String> GetSprintNames() {
    return FetchSprintNames() as List<String>;
  }
}
