import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dypalerts/customWidgets/bottomNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFab = false;

  void _fabChanged() {
    setState(() {
      _showFab = (!_showFab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('title'),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              FlatButton(
                child: Text('Toggle FAB'),
                onPressed: () {
                  _fabChanged();
                },
              ),
              Card(
                elevation: 8,
                child: Column(
                  children: [
                    Text(
                      'Heading of Notice',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Some long text here it is soo long description that it tries to overflow',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              mini: true,
              child: Icon(Icons.share),
              onPressed: () {
                print('fab closed');
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
