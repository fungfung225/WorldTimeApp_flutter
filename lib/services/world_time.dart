import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time ; // the time in that location
  late String flag; // url to an asset flag icon
  late String ull;  // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location,required this.flag,required this.ull});


  Future <void> getTime() async {
    var url = Uri.parse( "http://worldtimeapi.org/api/timezone/$ull" );

    var response = await http.get(url);

    Map data = jsonDecode(response.body);
    //print(data);

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    //print(datetime);
    //print(offset);

    //create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set the time property
    isDaytime = now.hour >6 &&now.hour <20 ? true : false;
    time = DateFormat.jm().format(now);

  }
}


