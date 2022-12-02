import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Board.dart';
import '../Task.dart';
import '../User.dart';

/**
 * This class access the API used to get information
 * for board/tasks and users
 */
class ApiAccess {
  Future<Board> FetchBoard(String boardTitle) async {
    final uri =
        Uri.parse('https://10.0.2.2:7132/GetScrumboard?boardTitle=$boardTitle');
    Response response = await get(uri);
    dynamic parsedJson = json.decode(response.body);
    Board board = Board.fromJson(json.decode(response.body));
    if (board == null) {
      return new Board(0, "null", List<Task>.empty());
    }
    return board;
  }

  void CreateSprint(String name) {
    http.post(Uri.parse('https://10.0.2.2:7132/PostScrumboard?title=$name'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  Future<List<String>> FetchAllSprintNames() async {
    final uri = Uri.parse('https://10.0.2.2:7132/GetSprintNames');
    Response response = await get(uri);
    //List<String> parsedListJson = json.decode(response.body);
    List<String> stringList =
        (jsonDecode(response.body) as List<dynamic>).cast<String>();

    return stringList;
  }

  void PostTask(Task task) {
    String title = task.title;
    String desc = task.description;
    String assign = task.assignedTo;
    String sprint = task.boardTitle;
    int points = task.points;
    int state = task.state.index;
    int prio = task.priority.index;
    int id = task.id;
    http.post(
        Uri.parse(
            'https://10.0.2.2:7132/PostTask?Id=$id&Title=$title&Description=$desc&Points=$points&AssignedTo=$assign&Sprint=$sprint&State=$state&Priority=$prio'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  void UpdateTask(Task task) {
    int id = task.id;
    String title = task.title;
    String desc = task.description;
    String assign = task.assignedTo;
    int points = task.points;
    int state = task.state.index;
    int prio = task.priority.index;
    http.put(
        Uri.parse(
            'https://10.0.2.2:7132/UpdateTask?Id=$id&Title=$title&Description=$desc&Points=$points&AssignedTo=$assign&State=$state&Priority=$prio'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  void DeleteTask(int id) {
    http.delete(Uri.parse('https://10.0.2.2:7132/DeleteTask?id=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  List<BoardState> SortStates(List<BoardState> states) {
    List<BoardState> tempList = states;
    for (int i = 0; i < tempList.length; i++) {
      BoardState temp = tempList[i];
      if (temp.title == "TODO") {
        tempList[i] = tempList[0];
        tempList[0] = temp;
      } else if (temp.title == "IN PROGRESS") {
        tempList[i] = tempList[1];
        tempList[1] = temp;
      } else if (temp.title == "REVIEW") {
        tempList[i] = tempList[2];
        tempList[2] = temp;
      } else if (temp.title == "DONE") {
        tempList[i] = tempList[3];
        tempList[3] = temp;
      }
    }
    return tempList;
  }

  Future<User> Login(String username, String password) async {
    Response response = await http.post(
        Uri.parse(
            'https://10.0.2.2:7132/LoginUser?username=$username&password=$password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    dynamic parsedJson = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    return User(parsedJson['username'], parsedJson['isScrumMaster']);
  }
}
