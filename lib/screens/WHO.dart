import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhoStandards extends StatelessWidget {
  var data;
  var len;
    @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WHO Precautions'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.0,5,15,5),
                child: Text('Basic protective measures against the new coronavirus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0,5,15,5),
                child: Text('Stay aware of the latest information on the COVID-19 outbreak, available on the WHO website and through your national and local public health authority. Most people who become infected experience mild illness and recover, but it can be more severe for others. Take care of your health and protect others by doing the following:'),
              ),
              expansionTile('Wash your hands frequently','Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water','Why? Washing your hands with soap and water or using alcohol-based hand rub kills viruses that may be on your hands.'),
              expansionTile('Maintain social distancing','Maintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing','Why? When someone coughs or sneezes they spray small liquid droplets from their nose or mouth which may contain virus. If you are too close, you can breathe in the droplets, including the COVID-19 virus if the person coughing has the disease.'),
              expansionTile('Avoid touching eyes, nose and mouth','','Why? Hands touch many surfaces and can pick up viruses. Once contaminated, hands can transfer the virus to your eyes, nose or mouth. From there, the virus can enter your body and can make you sick.'),
              expansionTile('Practice respiratory hygiene','Make sure you, and the people around you, follow good respiratory hygiene. This means covering your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately.','Why? Droplets spread virus. By following good respiratory hygiene you protect the people around you from viruses such as cold, flu and COVID-19'),
              expansionTile('If you have fever, cough and difficulty breathing, seek medical care early','Stay home if you feel unwell. If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority.','Why? National and local authorities will have the most up to date information on the situation in your area. Calling in advance will allow your health care provider to quickly direct you to the right health facility. This will also protect you and help prevent spread of viruses and other infections.'),
              expansionTile('Stay informed and follow advice given by your healthcare provider','Stay informed on the latest developments about COVID-19. Follow advice given by your healthcare provider, your national and local public health authority or your employer on how to protect yourself and others from COVID-19.','Why? National and local authorities will have the most up to date information on whether COVID-19 is spreading in your area. They are best placed to advise on what people in your area should be doing to protect themselves.'),
              expansionTile('Protection measures for persons who are in or have recently visited (past 14 days) areas where COVID-19 is spreading','Follow the guidance outlined above.\nStay at home if you begin to feel unwell, even with mild symptoms such as headache and slight runny nose, until you recover. Why? Avoiding contact with others and visits to medical facilities will allow these facilities to operate more effectively and help protect you and others from possible COVID-19 and other viruses.','If you develop fever, cough and difficulty breathing, seek medical advice promptly as this may be due to a respiratory infection or other serious condition. Call in advance and tell your provider of any recent travel or contact with travelers. Why? Calling in advance will allow your health care provider to quickly direct you to the right health facility. This will also help to prevent possible spread of COVID-19 and other viruses.')
            ],
          ),
        ),
      ),
    );
  }
}

class expansionTile extends StatelessWidget {

  expansionTile(this.text,this.answer,
      this.why);
  var text;
  var answer;
  var why;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,5,15,5),
          child: Text(answer),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,5,15,5),
          child: Text(why),
        )

      ],

    );
  }
}
