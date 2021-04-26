import 'package:flutter/material.dart';
import 'package:flutter_day1/Page2.dart';
import 'package:flutter_day1/http_connect.dart';
import 'package:flutter_day1/listuser_model.dart';

import 'my_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.black45,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
      routes: {'/Page2': (context) => Page2()},
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  GlobalKey<ScaffoldState> _key_scaffold = GlobalKey<ScaffoldState>();
  bool Val = false;
  String radioItem = '';
  List<Datum> data = [];

  Future<void> senddata() async {
    var res = await Connect_API.post(
        'api/login', {"email": "eve.holt@reqres.in", "password": "cityslicka"});
    print(res);
  }

  Future<void> getdata() async {
    var res = await Connect_API.get('api/users?page=2');
    //print(res);
    var datauser = listUserFromJson(res);
    setState(() {
      data = datauser.data;
    });
    // print(data);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key_scaffold,
      appBar: AppBar(
        title: Text("Hello Word"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Header"),
              decoration: BoxDecoration(color: Colors.deepOrange),
            )
          ],
        ),
      ),
      backgroundColor: Colors.deepOrange.shade200,
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: my_list(
            name: data[index].firstName,
            email: data[index].email,
            url: data[index].avatar,
            ontap: () {
              _key_scaffold.currentState.showSnackBar(
                SnackBar(
                  content:
                      Text("${data[index].firstName}  ${data[index].lastName}"),
                ),
              );
            },
          ),
        ),
        itemCount: data.length,
      ),
    );
  }
}
