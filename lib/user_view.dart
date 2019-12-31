import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/models/user.dart';

class UserView extends StatelessWidget {
  final User user;

  const UserView({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.name, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(user.email),
              Text(user.company),
              Text(user.age.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
