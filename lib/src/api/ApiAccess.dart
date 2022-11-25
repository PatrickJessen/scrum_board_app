import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Board.dart';
import '../Task.dart';
import '../User.dart';

class ApiAccess {
  Future<List<BoardState>> FetchBoard() async {
    final uri = Uri.parse('https://localhost:7132/GetScrumboard');
    Response response = await get(uri);
    List<dynamic> parsedListJson = json.decode(response.body)['states'];
    List<BoardState> list;
    list = (parsedListJson).map((data) => BoardState.fromJson(data)).toList();
    if (list.isEmpty) {
      return parsedListJson as List<BoardState>;
    }
    return SortStates(list);
  }

  void PostTask(Task task) {
    String title = task.title;
    String desc = task.description;
    String assign = task.assignedTo;
    int points = task.points;
    int state = task.state.index;
    int prio = task.priority.index;
    http.post(
        Uri.parse(
            'https://localhost:7132/PostTask?Title=$title&Description=$desc&Points=$points&AssignedTo=$assign&State=$state&Priority=$prio'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  void UpdateTask(Task task) {
    //https://localhost:7132/UpdateTask?Id=1&Title=newest%20title&Description=newest%20desc&Points=3&AssignedTo=me&State=0&Priority=2
    int id = task.id;
    String title = task.title;
    String desc = task.description;
    String assign = task.assignedTo;
    int points = task.points;
    int state = task.state.index;
    int prio = task.priority.index;
    http.put(
        Uri.parse(
            'https://localhost:7132/UpdateTask?Id=$id&Title=$title&Description=$desc&Points=$points&AssignedTo=$assign&State=$state&Priority=$prio'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  void DeleteTask(int id) {
    //https://localhost:7132/DeleteTask?id=1
    http.put(Uri.parse('https://localhost:7132/DeleteTask?id=$id'),
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
            'https://localhost:7132/LoginUser?username=$username&password=$password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    dynamic parsedJson = json.decode(response.body);
    if (parsedJson['username'] == null) {
      return null;
    }
    return User(parsedJson['username'], parsedJson['isScrumMaster']);
  }
}
