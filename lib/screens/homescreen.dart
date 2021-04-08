import 'package:cutups_rebuild/screens/help_screen.dart';
import 'package:cutups_rebuild/services/gutenberg_random.dart';
import 'package:flutter/material.dart';
import 'package:cutups_rebuild/screens/editing_screen.dart';
import 'package:cutups_rebuild/services/split_logic.dart';
import 'package:cutups_rebuild/services/dictionary_sentence.dart';

//May want to create a project wide constant folder for this. Currently these constants are used here and recreated exactly as is in split_logic class file
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

  void splitTextClassTest(String dropDownValue) {
    SplitTextLogic splitLogic = SplitTextLogic(
        inputTextFromHomeScreen: inputText,
        singleLinesFromHomesScreen: singleLines,
        textController: _controller,
        dropDownValueFromList: dropDownValue);

    splitLogic.splitTextLogic();
    print("from the split text class");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        leading: TextButton(
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
        actions: [
          TextButton(
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
          TextButton(
            onPressed: () async {
              print("random was pressed");
              DictionarySentence sentence = DictionarySentence();
              inputText = await sentence.randomDictionarySentence();

              setState(() {
                // inputText = loadedSentence;
                _controller.text = inputText;
              });
            },
            // onPressed: () async {
            //   print('randomnn pressed');
            //   GutenbergRandom random = GutenbergRandom();
            //   String randomPassage = await random.randomGutenberg();
            //   print('I am from homescreen $randomPassage');
            //   setState(() {
            //     inputText = randomPassage;
            //     _controller.text = randomPassage;
            //   });
            // },
            child: Text(
              'Random',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: CutDropDown(
              cutStyle: splitTextClassTest,
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
