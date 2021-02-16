import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.lightBlue,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          '''Cut-ups is a creativity process originated by the Dadaists in which existent cohoerent lines and passages of text are cut-up and rearranged to inspire new narrative ideas. This app attempts to recreate that process.

- On the home screen type in or paste in any text you want.

- Then click on the scissors icon to choose a cut-up method.

- Click on "Edit" to go to the editing page where you can manually rearange your lines of text or click on the shuffle icon to rearrange the lines randomly.

- Click the back button in the app bar to go back to the homescreen where you can enter more text to cut in if you wish.

- On the editing screen, you can click on the share icon to export your cut-up, or click on the trash icon to start over.
''',
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    );
  }
}
