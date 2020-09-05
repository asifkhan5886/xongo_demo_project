import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xongo_demo_app/bloc/xongo_bloc.dart';
import 'package:xongo_demo_app/wish_list.dart';

import 'databse/tags_list_table.dart';
import 'models/response_model.dart';

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MemoDbProvider tagDb = MemoDbProvider();
  @override
  void initState() {
    xongo.fetchXongoData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tag List Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: 26.0,
            ),
            tooltip: "Wish List",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WishListScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<List<String>>(
            stream: xongo.getTags,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length != null && snapshot.data.length != 0) {
                  return RefreshIndicator(
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(snapshot.data[index]),
                                    InkWell(
                                        onTap: () async {
                                          var rng = new Random();

                                          TagModel item;
                                          item = TagModel();
                                        //  item.id = index;
                                          item.tag = snapshot.data[index];
                                          tagDb.addItem(item);
                                        },
                                        child: Icon(Icons.add))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    onRefresh: () async {
                      await Future<void>.delayed(Duration(seconds: 1));
                      xongo.fetchXongoData();
                    },
                  );
                } else {
                  return Text(
                    "No data Found",
                    style: TextStyle(fontSize: 20),
                  );
                }
              }
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColorDark,
              ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          xongo.fetchXongoData();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
