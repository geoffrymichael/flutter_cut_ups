import 'package:flutter/material.dart';

class EditingScreen extends StatefulWidget {
  EditingScreen({this.fromCuttingScreen});
  final List<String> fromCuttingScreen;

  @override
  _EditingScreenState createState() => _EditingScreenState();
}

List<String> createListFromHomescreen(List<String> list) {
  return list;
}

class _EditingScreenState extends State<EditingScreen> {
  List<String> listForList = [];

  void initState() {
    super.initState();
    listForList = createListFromHomescreen(widget.fromCuttingScreen);
  }

  void randomizeList(List<String> list) {
    setState(() {
      list.shuffle();
    });
  }

  List<String> sampleList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, listForList);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              randomizeList(listForList);
            },
            child: Icon(
              Icons.shuffle,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);

          return false;
        },
        child: SafeArea(
          child: ReorderableListView(
            children: [
              for (final item in listForList)
                Dismissible(
                  key: Key(item),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    var delIndex = listForList.indexOf(item);
                    setState(() {
                      listForList.remove(item);
                    });
                  },
                  child: Card(
                    key: Key(item),
                    elevation: 2,
                    child: ListTile(
                      title: Text(item),
                    ),
                  ),
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = listForList.removeAt(oldIndex);
                listForList.insert(newIndex, item);
              });
            },
          ),
        ),
      ),
    );
  }
}
