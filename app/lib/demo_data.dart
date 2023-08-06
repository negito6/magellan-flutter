import 'models/point.dart';
import 'models/route_points.dart';

class DemoData {
  Iterable<RoutePoints> getAllRoutes() {
    final points = getAllPoints();
    return [RoutePoints('company', [0, 1, 2, 3].map((id) => points.elementAt(id)).toList(), 3)];
  }

  Iterable<Point> getAllPoints() {
    return [
      Point(35.646723 , 139.8040073, 'A'),
      Point(35.6930598, 139.7211194, 'BC'),
      Point(35.6685388, 139.7378426, 'DEFG'),
      Point(35.6274289, 139.7260393, 'HIJKLMN'),
      Point(35.553333 , 139.781113,  '羽田空港'),
      Point(35.7658   , 140.3863,    '成田空港'),
    ];
  }
}
