import 'package:flutter/material.dart';
import '../models/point.dart';

class PointList extends StatelessWidget {
  List<Point> pointList;
  String title;

  PointList(this.pointList, this.title);
  PointList.notitle(this.pointList): title = 'Points';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
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
