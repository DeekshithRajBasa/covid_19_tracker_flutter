import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  _launchURL(urlPass) async {
    var url = urlPass;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List pac = [
    'cupertino_icons: ^0.1.2',
    'http: ^0.12.0+4',
    'google_nav_bar: ^2.1.0',
    'percent_indicator: ^2.1.1+1',
    'font_awesome_flutter: ^8.8.1',
    'url_launcher: ^5.4.2',
    'loading: ^1.0.2'
  ];
List apiLinks = ['https://corona.lmao.ninja/countries?sort=country','https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats','https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search'];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.info, color: Colors.white,),
            SizedBox(width: 5,),
            Text("App Info",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        ClipRRect(
                          child: Image.asset(
                            'assets/images/deekshith.jpg',
                            height: 80,
                            width: 80,
                          ),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Deekshith Raj Basa',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Angular and Flutter Developer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),

                      ],
                    ),
SizedBox(
  height: 10,
),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.instagram.com/deekshith_raj_basa');
                            },
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              size: 35.0,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.facebook.com/deekshithraj.basa');
                            },
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              size: 35.0,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://twitter.com/deekshithrajb');
                            },
                            child: Icon(
                              FontAwesomeIcons.twitter,
                              size: 35.0,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://in.linkedin.com/in/deekshith-raj-basa-36718753');
                            },
                            child: Icon(
                              FontAwesomeIcons.linkedin,
                              size: 35.0,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://github.com/DeekshithRajBasa');
                            },
                            child: Icon(
                              FontAwesomeIcons.github,
                              size: 35.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Text('v 1.1.2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: width - 25,
                      child: Card(
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'Packages Used',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              children: <Widget>[
                                  Text(pac[0],style: TextStyle(fontSize: 20),),
                                  Text(pac[1],style: TextStyle(fontSize: 20),),
                                  Text(pac[2],style: TextStyle(fontSize: 20),),
                                  Text(pac[3],style: TextStyle(fontSize: 20),),
                                  Text(pac[4],style: TextStyle(fontSize: 20),),
                                  Text(pac[5],style: TextStyle(fontSize: 20),),
                                  Text(pac[6],style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width - 25,
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[

                              ExpansionTile(
                              title:  Text(
                                'Api Links',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              children: <Widget>[
                                Text(apiLinks[0],style: TextStyle(fontSize: 16, decoration: TextDecoration.underline,color: Colors.blue),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(apiLinks[1],style: TextStyle(fontSize: 16, decoration: TextDecoration.underline,color: Colors.blue),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(apiLinks[2],style: TextStyle(fontSize: 16, decoration: TextDecoration.underline,color: Colors.blue),),
                              ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
