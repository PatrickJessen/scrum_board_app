import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Board.dart';

class BoardApi {
  Board ParseBoard(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //return parsed.map<Board>((json) => Board.fromJson(json));
    return Board();
  }

  Future<List<BoardState>> FetchBoard() async {
    final uri = Uri.parse('https://localhost:7132/GetScrumboard');
    final response =
        await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> parsedListJson = json.decode(response.body)['states'];
      List<BoardState> list = (parsedListJson).map((data) => BoardState.fromJson(data)).toList();
      print(list.length);
      return SortStates(list);
    }
  }

  List<BoardState> SortStates(List<BoardState> states){
    List<BoardState> tempList = states;
    for (int i = 0; i < tempList.length; i++){
      BoardState temp = tempList[i];
      if (temp.title == "TODO"){
        tempList[i] = tempList[0];
        tempList[0] = temp;
      }
      else if (temp.title == "IN PROGRESS"){
        tempList[i] = tempList[1];
        tempList[1] = temp;
      }
      else if (temp.title == "REVIEW"){
        tempList[i] = tempList[2];
        tempList[2] = temp;
      }
      else if (temp.title == "DONE"){
        tempList[i] = tempList[3];
        tempList[3] = temp;
      }
    }
    return tempList;
  }
}
