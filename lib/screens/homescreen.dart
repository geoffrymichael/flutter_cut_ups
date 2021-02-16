import 'package:cutups_rebuild/screens/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:cutups_rebuild/screens/editing_screen.dart';

const Map howToSeparate = {
  1: 'Single Lines',
  3: 'Every 3rd Word',
  5: 'Every 5th Word',
  0: 'Single Words'
};

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> singleLines = [];

  final TextEditingController _controller = TextEditingController();

  String inputText;

  void splitText(String dropDownValue) {
    if (dropDownValue == howToSeparate[1]) {
      print('singleLines');
      if (inputText == null || inputText.isEmpty) {
        print("null line");
      } else {
        List<String> newTextData = inputText.split('\n');
        for (String line in newTextData) {
          singleLines.add(line);
        }
        _controller.clear();
        inputText = '';
      }
    } else {
      if (dropDownValue == howToSeparate[3]) {
        if (inputText == null || inputText.isEmpty) {
          print('nothing to cut');
        } else {
          if (inputText == null || inputText.isEmpty) {
            print('nothing to cut');
          } else {
            String singleLine = inputText.replaceAll('\n', ' ');

            var singleWords = singleLine.split(' ');

            var chunks = [];
            for (var i = 0; i < singleWords.length; i += 3) {
              chunks.add(singleWords.sublist(
                  i, i + 3 > singleWords.length ? singleWords.length : i + 3));
            }

            for (var item in chunks) {
              final newString = item.join(' ');
              singleLines.add(newString);
            }
            _controller.clear();
            inputText = '';
          }
        }
      } else {
        if (dropDownValue == howToSeparate[5]) {
          if (inputText == null || inputText.isEmpty) {
            print('nothing to cut');
          } else {
            if (inputText == null || inputText.isEmpty) {
              print('nothing to cut');
            } else {
              String singleLine = inputText.replaceAll('\n', ' ');

              var singleWords = singleLine.split(' ');

              var chunks = [];
              for (var i = 0; i < singleWords.length; i += 5) {
                chunks.add(singleWords.sublist(i,
                    i + 3 > singleWords.length ? singleWords.length : i + 5));
              }

              for (var item in chunks) {
                final newString = item.join(' ');
                singleLines.add(newString);
              }
              _controller.clear();
              inputText = '';
            }
          }
        } else {
          if (dropDownValue == howToSeparate[0]) {
            if (inputText == null || inputText.isEmpty) {
              print('nothing to cut');
            } else {
              String singleLine = inputText.replaceAll('\n', ' ');
              List<String> singleWord = singleLine.split(' ');
              for (String word in singleWord) {
                singleLines.add(word);
              }
              _controller.clear();
              inputText = '';
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }),
            );
          },
          child: Text(
            'Help',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditingScreen(fromCuttingScreen: singleLines);
              }));
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: CutDropDown(
              cutStyle: splitText,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: TextField(
            onChanged: (value) {
              inputText = value;
            },
            controller: _controller,
            enableInteractiveSelection: true,
            maxLines: 9999,
          ),
        ),
      ),
    );
  }
}

class CutDropDown extends StatelessWidget {
  CutDropDown({this.cutStyle, this.dropDownValue});
  final Function cutStyle;
  final String dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(
        Icons.cut_sharp,
        color: Colors.black,
      ),
      items: <String>[
        howToSeparate[1],
        howToSeparate[3],
        howToSeparate[5],
        howToSeparate[0]
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: cutStyle,
    );
  }
}
