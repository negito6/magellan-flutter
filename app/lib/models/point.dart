import 'package:latlong2/latlong.dart';

class Point {
  int id = 0;
  String? name;
  double lat;
  double lng;
  // Tag[] tags;

  Point(this.lat, this.lng, this.name);

  LatLng latlng() {
    return LatLng(lat, lng);
  }
}
