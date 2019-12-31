import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/models/user.dart';
import 'package:flutter_sticky_header/models/user_view_info.dart';
import 'package:flutter_sticky_header/user_view.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Header Demo'),
      ),
      body: FutureBuilder(
          future: _getUserList(),
          builder: (context, snapshot) {
            if(snapshot.hasError) print(snapshot.error);
            if (snapshot.data == null) return Center(child: CircularProgressIndicator());

            final groupList = _groupByDate(snapshot.data);
            return ListView.builder(
              itemBuilder: (context, index) =>
                  StickyHeader(
                      header: groupList[index].header,
                      content: groupList[index].child
                  ),
              itemCount: groupList.length,
            );
          }),
    );
  }
}

Future<List<User>> _getUserList() async {
  final response = await http.get('https://raw.githubusercontent.com/prolongservices/Fake-Json/master/json/users.json');
  return List.castFrom(json.decode(response.body)).map((c) => User.fromJson(c)).toList();
}

List<UserViewInfo> _groupByDate(List<User> companyList) {
  final map = groupBy(
      keySelector: (User c) => DateFormat("MMMM").format(c.registered),
      list: companyList
  );

  return toList(
      mapF: (String date, List<User> list) {
        final header = Container(
          width: double.infinity,
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );

        final children = list.map((u) => UserView(user: u,)).toList();
        final child = Column(children: children,);

        return UserViewInfo(header: header, child: child);
      },
      map: map
  );
}

Map<K, List<T>> groupBy<T, K>({K Function(T) keySelector, List<T> list}) {
  Map<K, List<T>> destination = Map();

  for (T element in list) {
    final key = keySelector(element);
    final value = destination[key] ?? List();
    value.add(element);
    destination[key] = value;
  }

  return destination;
}

List<R> toList<K, V, R>({R Function(K, V) mapF, Map<K, V> map}) {
  List<R> destination = List();
  map.forEach((k, v) => destination.add(mapF(k, v)));
  return destination;
}