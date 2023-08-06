import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'models/point.dart';
import 'models/route_points.dart';
import 'widgets/route_list.dart';
import 'widgets/point_list.dart';
import 'demo_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magellan',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final mapController = MapController();
  final data = DemoData();
  final initialRouteId = 0;
  RoutePoints currentRoute = RoutePoints('', [], 0);

  _MyHomePageState() {
    currentRoute = this.getRoute(this.initialRouteId);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Iterable<RoutePoints> getAllRoutes() {
    return data.getAllRoutes();
  }

  Iterable<Point> getAllPoints() {
    return data.getAllPoints();
  }

  RoutePoints getRoute(int id) {
    return this.getAllRoutes().elementAt(id);
  }

  List<Marker> getMarkers(List<Point> points, int currentIndex) {
    final icons = [0xe270, 0xe271, 0xe272, 0xe273, 0xe274, 0xe275, 0xe276, 0xe277, 0xe278, 0xe279];
    return points.asMap().entries.map((entry) {
       int index = entry.key;
       Point point = entry.value;
       return Marker(
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(IconData(icons[index], fontFamily: 'MaterialIcons'), color: index == currentIndex ? Colors.red : Colors.indigo),
        ),
        point: point.latlng(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentRoute.getCurrentPoint().latlng(),
          zoom: currentRoute.defaultZoom(),
          interactiveFlags: InteractiveFlag.all,
          enableScrollWheel: true,
          scrollWheelVelocity: 0.00001,
          // onMapReady: () {
          //   mapController.mapEventStream.listen((evt) {}); // And any other `MapController` dependent non-movement methods
          // },
        ),
        layers: [
          //背景地図読み込み (OSM)
          TileLayerOptions(
            urlTemplate: "https://tile.openstreetmap.jp/{z}/{x}/{y}.png",
          ),
          MarkerLayerOptions(
            markers: getMarkers(currentRoute.points, currentRoute.current),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo),
                child: Text("Menu")),
            ListTile(
              leading: Icon(Icons.route_outlined),
              title: Text('Routes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RouteList(this.getAllRoutes().toList())),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.location_pin),
              title: Text('Points'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointList.notitle(this.getAllPoints().toList())),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.deepOrangeAccent, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor: Colors.deepPurpleAccent, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild( //speed dial child
            child: Icon(Icons.location_pin),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Points',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PointList(currentRoute.points, "Points of ${currentRoute.name}")),
              );
            },
          ),
        ],
      ),
    );
  }
}
