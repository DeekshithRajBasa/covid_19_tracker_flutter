import 'package:covid19tracker/screens/globalStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class SearchCountries extends StatefulWidget {
  SearchCountries() : super();

  final String title = "All Countries";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<SearchCountries> {
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search, color: Colors.white,),
            SizedBox(width: 5,),
            Text(widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
      body:  users.length!=0? Container(
        child:  Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Search Country',
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filteredUsers = users
                          .where((u) => (u.name
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u.flag.toLowerCase().contains(string.toLowerCase())))
                          .toList();
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      filteredUsers[index].flag,
                                      height: 55,
                                      width: 55,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    filteredUsers[index].name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  filteredUsers[index].id.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ExpansionTile(
                            title: Text('View more details'),
                            children: <Widget>[
                              Casess('Active', Colors.blue, filteredUsers[index].active.toString()),
                              Casess('Deaths', Colors.red, filteredUsers[index].deaths.toString()),
                              Casess('Recovered', Colors.green, filteredUsers[index].recovered.toString()),
                              Casess('Today Cases', Colors.orange, filteredUsers[index].todayCases.toString()),
                              Casess('Today Deaths', Colors.red, filteredUsers[index].todayDeaths.toString()),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ) : Container(child: Center(child:  Loading(
          indicator: BallPulseIndicator(),
          size: 50.0,
          color: Colors.deepPurple),
      ),),);
  }
}

class Services {
  static const String url = 'https://corona.lmao.ninja/countries?sort=country';

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}

class User {
  int id;
  String name;
  String flag;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;

  User(
      {this.id,
      this.name,
      this.flag,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["cases"] as int,
      name: json["country"] as String,
      flag: json["countryInfo"]['flag'] as String,
      cases: json['cases'] as int,
      todayCases: json['todayCases'] as int,
      deaths: json['deaths'] as int,
      todayDeaths: json['todayDeaths'] as int,
      recovered: json['recovered'] as int,
      active: json['active'] as int,
    );
  }
}
