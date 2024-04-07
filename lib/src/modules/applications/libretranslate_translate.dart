import 'dart:convert';

import 'package:app_store/src/core/translate.dart';
import 'package:http/http.dart' as http;

class LibreTranslate extends Translate {
  @override
  Future fromString(String data) async {
    List translateList = [];
    Map<String, dynamic> translateMap = {};
    const base = "http://191.252.103.249:5000/translate";

    if (jsonDecode(data) is List) {
      Iterable body = jsonDecode(data);
      final map = List<Map<dynamic, dynamic>>.from(body.map((e) => e));
      int count = map.length >= 45 ? 35 : map.length;
      //Set data lenght return
      for (int i = 0; i < count; i++) {
        final response = await http.post(
          Uri.parse(base),
          body: jsonEncode({
            "q": map[i]["summary"],
            "source": "en",
            "target": "pt",
            "format": "text"
          }),
          headers: {"Content-Type": "application/json"},
        );
        map[i].update(
            "summary",
            (value) => jsonDecode(
                utf8.decode(response.body.runes.toList()))["translatedText"]);

        translateList.add(map[i]);
      }

      return translateList;
    }

    if (jsonDecode(data) is Map) {
      final body = Map<String, dynamic>.from(jsonDecode(data));
      final response = await http.post(
        Uri.parse(base),
        body: jsonEncode({
          "q": [body["summary"], body["description"]],
          "source": "en",
          "target": "pt",
          "format": "text"
        }),
        headers: {"Content-Type": "application/json"},
      );
      body.update(
          "summary",
          (value) => jsonDecode(
              utf8.decode(response.body.runes.toList()))["translatedText"][0]);
      body.update(
          "description",
          (value) => jsonDecode(
              utf8.decode(response.body.runes.toList()))["translatedText"][1]);

      translateMap = body;
    }

    return translateMap;
  }
}
