import 'package:flutter/material.dart';
import 'package:share/share.dart';

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

  void share(BuildContext context, List<String> cutUp) {
    final RenderBox box = context.findRenderObject();
    final String text = cutUp.join("\n");
    print(text);
    Share.share(
      text,
      subject: 'Check out my Cut-up',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.black),
      ),
    );

    Widget continueButton = TextButton(
      onPressed: () {
        setState(() {
          listForList.clear();
          Navigator.of(context).pop();
        });
      },
      child: Text(
        'Continue',
        style: TextStyle(color: Colors.red),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete your Cut-up?"),
      content:
          Text("If you haven't shared it, it will be gone forever. Continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
              showAlertDialog(context);
            },
            child: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              share(context, listForList);
            },
            child: Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
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
