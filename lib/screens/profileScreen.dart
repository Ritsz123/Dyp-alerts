import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg.png'),
                  ),
//                  gradient: LinearGradient(
//                    colors: [Color(0xfff12711), Color(0xfff5af19)],
//                    stops: [0.0, 0.7],
//                  ),
                ),
                child: Column(
                  children: [
                    Card(
                      child: CircleAvatar(
                        radius: screenHeight(context: context, divideBy: 13),
                        backgroundColor: Colors.yellowAccent,
                        //TODO: change color to background image
                      ),
                      elevation: 10,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                    ),
                    Text(
                      'AppSignInUser',
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(
                      'developer@gmail.com',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    Align(
                      child: Text(
                        'Account Info',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    UserInfoTile(
                      title: 'Name',
                      info: 'Ritesh Khadse',
                    ),
                    UserInfoTile(
                      title: 'Mobile',
                      info: '9876543210',
                    ),
                    UserInfoTile(
                      title: 'Email',
                      info: 'developer@dypALerts.com',
                    ),
                    UserInfoTile(
                      title: 'D.O.B.',
                      info: '12-06-2000',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  UserInfoTile({@required this.title, @required this.info});
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: EdgeInsets.all(0),
      title: Text(
        title,
        style: kProfileDescTitle,
      ),
      subTitle: Text(
        info,
        style: kProfileDescInfo,
      ),
      avatar: Icon(Icons.account_circle),
    );
  }
}
