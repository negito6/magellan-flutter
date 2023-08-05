import 'point.dart';

class RoutePoints {
  int id = 0;
  String name;
  List<Point> points;
  // arrivedAt
  // leftAt
  int current = 0;
  bool archived = false;

  RoutePoints(this.name, this.points, this.current);
}
