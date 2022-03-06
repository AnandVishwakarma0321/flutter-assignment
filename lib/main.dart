import 'package:filter_listview_example/page/now_playing_list.dart';
import 'package:filter_listview_example/page/top_rated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Filter & Search ListView';

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        // darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.amber,
            appBarTheme: AppBarTheme(backgroundColor: Colors.yellow[400]),
            bottomAppBarColor: Colors.yellow[400]),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.slow_motion_video_sharp,
            color: Colors.black,
          ),
          title: Text(
            'Now Playing',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_border,
            color: Colors.black,
          ),
          title: Text(
            'Top Rated',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return FilterLocalListPage();
      case 1:
        return FilterNetworkListPage();
      default:
        return Container();
    }
  }
}
