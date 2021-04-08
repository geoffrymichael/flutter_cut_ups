import 'dart:convert';

import 'package:http/http.dart' as http;

class DictionarySentence {
  Future<String> randomDictionarySentence() async {
    String sentence;
    String API = "0pyour0llyatx4tcrq4dsgcoukg1aasqt8rnubxljcc1r8l3n";
    String url =
        "https://api.wordnik.com/v4/word.json/scuttle/topExample?useCanonical=false&api_key=$API";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("status okay");

      var parsedJson = json.decode(response.body);
      var sentence = parsedJson['text'];
      print(sentence);
    } else {
      print("something went wrong");
    }

    return sentence;
  }
}
