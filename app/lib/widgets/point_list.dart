import 'package:flutter/material.dart';
import '../models/point.dart';

class PointList extends StatelessWidget {
  PointList(this.pointList);
  List<Point> pointList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: this.pointList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Text(this.pointList[index].name ?? 'No name'),
          );
        }
      ),
    );
  }
}
