import 'package:flutter/material.dart';

class SplitTextLogic {
  String inputTextFromHomeScreen;
  final List<String> singleLinesFromHomesScreen;
  final String dropDownValueFromList;
  final TextEditingController textController;

  SplitTextLogic(
      {this.inputTextFromHomeScreen,
      this.singleLinesFromHomesScreen,
      this.dropDownValueFromList,
      this.textController});

  static const Map howToSeparate = {
    1: 'Single Lines',
    3: 'Every 3rd Word',
    5: 'Every 5th Word',
    0: 'Single Words'
  };

  void splitTextLogic() {
    if (dropDownValueFromList == howToSeparate[1]) {
      print('singleLines');
      if (inputTextFromHomeScreen == null || inputTextFromHomeScreen.isEmpty) {
        print("null line");
      } else {
        List<String> newTextData = inputTextFromHomeScreen.split('\n');
        for (String line in newTextData) {
          singleLinesFromHomesScreen.add(line);
        }
        textController.clear();
        inputTextFromHomeScreen = '';
      }
    } else {
      if (dropDownValueFromList == howToSeparate[3]) {
        if (inputTextFromHomeScreen == null ||
            inputTextFromHomeScreen.isEmpty) {
          print('nothing to cut');
        } else {
          if (inputTextFromHomeScreen == null ||
              inputTextFromHomeScreen.isEmpty) {
            print('nothing to cut');
          } else {
            String singleLine = inputTextFromHomeScreen.replaceAll('\n', ' ');

            var singleWords = singleLine.split(' ');

            var chunks = [];
            for (var i = 0; i < singleWords.length; i += 3) {
              chunks.add(singleWords.sublist(
                  i, i + 3 > singleWords.length ? singleWords.length : i + 3));
            }

            for (var item in chunks) {
              final newString = item.join(' ');
              singleLinesFromHomesScreen.add(newString);
            }
            textController.clear();
            inputTextFromHomeScreen = '';
          }
        }
      } else {
        if (dropDownValueFromList == howToSeparate[5]) {
          if (inputTextFromHomeScreen == null ||
              inputTextFromHomeScreen.isEmpty) {
            print('nothing to cut');
          } else {
            if (inputTextFromHomeScreen == null ||
                inputTextFromHomeScreen.isEmpty) {
              print('nothing to cut');
            } else {
              String singleLine = inputTextFromHomeScreen.replaceAll('\n', ' ');

              var singleWords = singleLine.split(' ');

              var chunks = [];
              for (var i = 0; i < singleWords.length; i += 5) {
                chunks.add(singleWords.sublist(i,
                    i + 3 > singleWords.length ? singleWords.length : i + 5));
              }

              for (var item in chunks) {
                final newString = item.join(' ');
                singleLinesFromHomesScreen.add(newString);
              }
              textController.clear();
              inputTextFromHomeScreen = '';
            }
          }
        } else {
          if (dropDownValueFromList == howToSeparate[0]) {
            if (inputTextFromHomeScreen == null ||
                inputTextFromHomeScreen.isEmpty) {
              print('nothing to cut');
            } else {
              String singleLine = inputTextFromHomeScreen.replaceAll('\n', ' ');
              List<String> singleWord = singleLine.split(' ');
              for (String word in singleWord) {
                singleLinesFromHomesScreen.add(word);
              }
              textController.clear();
              inputTextFromHomeScreen = '';
            }
          }
        }
      }
    }
  }
}
