import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //call api with example url
  //Ajman ID 292932
  //Example: api.openweathermap.org/data/2.5/weather?id=292932&appid={your key here}
  //docs: https://openweathermap.org/current
  Text name = Text(""), temp = Text(""), humidity = Text("");

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Clima"),
        ),
        elevation: 8.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              name,
              temp,
              humidity,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    print('Initialised');
    super.initState();
  }

  Future<void> getData() async {
    Response response;
    try {
      response = await get(
        "https://api.openweathermap.org/data/2.5/weather?id=292932&appid=$key&units=metric",
      );
      print(response.body);
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      if (response != null) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          name = Text(
            jsonDecode(response.body)['name'].toString(),
            style: textStyle,
          );
          temp = Text(
            "Temp: " + jsonDecode(response.body)['main']['temp'].toString(),
            style: textStyle,
          );
          humidity = Text(
            "Humidity: " +
                jsonDecode(response.body)['main']['humidity'].toString(),
            style: textStyle,
          );
        } else {
          name = Text(
            'Error fetching data',
            style: textStyle,
          );
          temp = Text(
            "",
          );
          humidity = Text(
            "",
          );
        }
      } else {
        name = Text(
          'No internet connection',
          style: textStyle,
        );
        temp = Text(
          "",
        );
        humidity = Text(
          "",
        );
      }
    });
  }
}
