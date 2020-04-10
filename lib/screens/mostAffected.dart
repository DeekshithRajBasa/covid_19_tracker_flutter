import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './globalStatus.dart';

class MostAffectedScreen extends StatelessWidget {
  MostAffectedScreen(this.data);
  var data;
  var len;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data['country']),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25,15.0,15,15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(child: Image.network(data['flag'], fit: BoxFit.cover,height: 100 , width: 100,), borderRadius: BorderRadius.circular(500),),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Total Cases', style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),),
                            Text(data['total_cases'],style: TextStyle(fontSize: 30, color: Colors.orange, fontWeight: FontWeight.w900),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Casess('Active Cases', Colors.deepPurpleAccent, data['active_cases']),
                Casess('Recovered Cases', Colors.green, data['total_recovered']),
                Casess('New Cases', Colors.blue, data['new_cases']),
                Casess('Deaths Cases', Colors.red, data['total_deaths']),
                Casess('New Deaths Cases', Colors.red, data['new_deaths']),
                Casess('Serious Critical Cases', Colors.red, data['serious_critical']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
