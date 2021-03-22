import 'package:flutter/material.dart';
import 'package:appmap/mapPage/mymap.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome To CameraApp'),
              bottom: TabBar(
                onTap: (index) {},
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.map)),
                  Tab(icon: Icon(Icons.person))
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: Text('Home'),
                ),
                Center(
                  child: MyMapPage(),
                ),
                Center(
                  child: Text('Home'),
                ),
              ],
            ),
          ),
        ));
  }
}
