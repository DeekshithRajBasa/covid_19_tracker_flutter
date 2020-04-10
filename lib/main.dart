import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:share/share.dart';
import 'screens/info.dart';
import 'screens/searchCountries.dart';
import 'screens/globalStatus.dart';
import 'screens/mostAffected.dart';
import 'screens/WHO.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'screens/maps-track.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'COVID 19 Tracker',
        theme: ThemeData(
          fontFamily: 'opensans',
          primaryColor: new Color(0xff290486),
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url =
      'https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats';
  final String mostEffectedCountriesurl =
      'https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search';

  var covidAllData;
  List covidMostEffectedCountries;
  int covidMostEffectedCountriesLen;
  List countries;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchJSON();

  }

  Future<dynamic> FetchJSON() async {
    var covidAllDataResponse = await http.get(url);
    var covidMostEffectedCountriesurlResponse =
        await http.get(mostEffectedCountriesurl);

    if (covidAllDataResponse.statusCode == 200) {

      setState(() {
        covidAllData = convertToJson(covidAllDataResponse)['data'];
        covidMostEffectedCountries =
        convertToJson(covidMostEffectedCountriesurlResponse)['data']
        ['rows'];
        covidMostEffectedCountriesLen = covidMostEffectedCountries.length;
      });
    }
  }

  int _selectedIndex =0;

  convertToJson(res) {
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      covidAllData != null
          ? mainScreen(covidAllData, covidMostEffectedCountries,
              covidMostEffectedCountriesLen)
          : Container(
              child: Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 50.0,
                  color: Colors.deepPurple),
            )),
      SearchCountries(),
      map(),
      InfoScreen(),
    ];
    return Scaffold(

      resizeToAvoidBottomPadding: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2)),
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 22,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Color(0xff290486),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.map,
                    text: 'Map',
                  ),
                  GButton(
                    icon: Icons.info,
                    text: 'Info',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Color(0xff290486),
        child: Icon(Icons.share),
        onPressed: () {
          Share.share(
              'Check out the COVID-19 Live tracker. Download the app from https://deekshithrajbasa.github.io/covid19-tracker');
        },
      ),
    );
  }
}

class mainScreen extends StatelessWidget {
  mainScreen(this.covidAllData, this.covidMostEffectedCountries,
      this.covidMostEffectedCountriesLen);

  var covidAllData;
  var covidMostEffectedCountries;
  var covidMostEffectedCountriesLen;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.my_location, color: Colors.white,),
                  SizedBox(width: 5,),
                  Text("Covid-19 Tracker",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              background: Image.network(
                'https://akm-img-a-in.tosshub.com/sites/btmt/images/stories/corona_660_150220041149.jpg',
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,15,0),
                    child: Icon(Icons.info_outline),
                  ))
            ],
          ),
        ];
      },
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Covid-19 Tracker',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              this.covidAllData['last_update'].toString() +
                                  ' ( United Kingdom )',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: new Icon(Icons.arrow_forward),
                      color: Colors.black,
                      onPressed: (() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GlobalStatus(covidAllData)),
                            )
                          }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: new Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xff290486),
                                      size: 18,
                                    ),
                                  ),
                                  color: Color(0xffebebeb),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                              child: Text(
                                this.covidAllData['total_cases'].toString(),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xff290486),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Cases',
                              style: TextStyle(
                                  color: Colors.grey,

                                  fontSize: 16.0),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                                color: Color(0xffebebeb),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                              child: Text(
                                this.covidAllData['death_cases'].toString(),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Deaths',
                              style: TextStyle(
                                  color: Colors.grey,

                                  fontSize: 16.0),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.cached,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                ),
                                color: Color(0xffebebeb),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                              child: Text(
                                this.covidAllData['recovery_cases'].toString(),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Recovered',
                              style: TextStyle(
                                  color: Colors.grey,

                                  fontSize: 16.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Most Affected Areas',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              MostAffected(
                  covidMostEffectedCountries, covidMostEffectedCountriesLen),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Take Precautions',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '( Source: W.H.O )',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              precautions(),
            ],
          ),
        ),
      ),
    );
  }
}

class MostAffected extends StatelessWidget {
  MostAffected(this.data, this.len);

  var data;
  var len;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Card(
                    child: Container(
                      width: 280,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(data[index]['flag']),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,

                        ),
                      ),
                      child:   Text('')
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4,0,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                          child: Text(
                            data[index]['country'] +
                                ' : ' +
                                data[index]['total_cases'],
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        MaterialButton(minWidth: 280,
                          elevation: 3,
                          color: Color(0xff290486),
                          child: new Text(
                            "Get More Details",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MostAffectedScreen(data[index])),
                            );
                          },

                        )
                      ],
                    ),
                  ),

                ],
              );
            }),
      ),
    );
  }
}

class precautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          MaterialPageRoute(builder: (context) => WhoStandards());
        },
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage('assets/images/doctor.png'),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.white.withOpacity(0)
                    ])),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 8.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'All you need to know \nabout COVID-19',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  OutlineButton(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: new Text(
                        "Know More",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WhoStandards()),
                      );
                    },
                    borderSide: BorderSide(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
