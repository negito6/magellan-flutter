import 'package:flutter/material.dart';
import '../models/route_points.dart';

class RouteList extends StatelessWidget {
  RouteList(this.routeList);
  List<RoutePoints> routeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: this.routeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Text(this.routeList[index].name),
          );
        }
      ),
    );
  }
}
