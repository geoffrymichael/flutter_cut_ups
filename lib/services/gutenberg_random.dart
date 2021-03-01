import 'dart:math';
import 'package:http/http.dart' as http;

class GutenbergRandom {
  Future<String> randomGutenberg() async {
    final random = Random();
    int newRandom = random.nextInt(1600);
    String randomPassage;

    String url =
        "https://www.gutenberg.org/cache/epub/$newRandom/pg$newRandom.txt";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('okay');
      String book = response.body;
      int randomPassageSectionStart =
          random.nextInt(response.body.length - 600);
      String result = book.substring(
          randomPassageSectionStart, randomPassageSectionStart + 500);
      randomPassage = result;
    } else {
      print('failed');
    }

    print(newRandom);
    return randomPassage;
  }
}
