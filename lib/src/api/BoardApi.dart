import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Board.dart';

class BoardApi {
  Board ParseBoard(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Board>((json) => Board.fromMap(json));
  }

  Future<Board> FetchBoard() async {
    final response =
        await http.get(Uri.parse("https://localhost:7132/GetScrumboard"));
    if (response.statusCode == 200) {
      return ParseBoard(response.body);
    } else {
      throw Exception('Unable to fetch board from the REST API');
    }
  }
}
