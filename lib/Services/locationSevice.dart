
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



class LocationService {
  Future<String> getPalceId(String input) async {
    final String url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$MapsApiKey";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;

  }


  Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  Future<Placemark> getLocationMarks(Position p) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(p.latitude, p.longitude);
    return placemarks[0];
  }

  double getDistanceBetween(Position start ,Position end)  {
    double distanceInMeters =  Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters/1000;
  }
}