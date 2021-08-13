import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDayTime; // true or flase if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response =  await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      // set time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }

  }
}