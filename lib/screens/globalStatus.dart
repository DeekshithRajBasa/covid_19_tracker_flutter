import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class GlobalStatus extends StatelessWidget {
  GlobalStatus(this.data);

  var data;
  var primaryColor = Color(0xff20639b);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Global Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.globe,
                            size: 25.0,
                            color: const Color(0xFF0099a9),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Total Cases',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Text(data['total_cases'],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange))
                        ],
                      ),
                    ),
                  ),
                ),
                Casess(
                    'Active Cases', Colors.orange, data['currently_infected']),
                Casess('Recovered Cases', Colors.green, data['recovery_cases']),
                Casess('Death Cases', Colors.red, data['death_cases']),
                Casess('Critical Cases', Colors.pink,
                    data['critical_condition_active_cases']),
                Indicator(data['active_cases_mild_percentage'], width,'Mild Cases', Colors.purple),
                Indicator(data['closed_cases_recovered_percentage'], width, 'Recovered Cases', Colors.green),
                Indicator(data['closed_cases_death_percentage'], width,'Death Cases', Colors.red),
                Indicator(data['active_cases_critical_percentage'], width,'Critical Cases', Colors.pink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Casess extends StatelessWidget {
  Casess(this.text, this.color, this.count);

  var color;
  var count;
  var text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6,8.0,6,8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0,15,10,15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.brightness_1,
                    color: color,
                    size: 15,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(count,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  Indicator(this.data, this.width, this.name, this.color);

  var data;
  var width;
  var color;
  var name;

  @override
  Widget build(BuildContext context) {
    var finaldata = data+' %';
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Casess(name, color,finaldata),
          Padding(
            padding: const EdgeInsets.fromLTRB(3,0,0,0),
            child: LinearPercentIndicator(
              width: width - 29,
              lineHeight: 8.0,
              percent: double.parse(data) / 100,
              progressColor: color,
              backgroundColor: color.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
