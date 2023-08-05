import 'package:latlong2/latlong.dart';

class Point {
  int id = 0;
  int? name;
  double lat;
  double lng;
  // Tag[] tags;

  Point(this.lat, this.lng);

  LatLng latlng() {
    return LatLng(lat, lng);
  }
}
