import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xongo_demo_app/bloc/xongo_bloc.dart';
import 'package:xongo_demo_app/databse/tags_list_table.dart';

import 'models/response_model.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  MemoDbProvider tagDb = MemoDbProvider();
  @override
  void initState() {
    xongo.fetchTableData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List Screen"),
      ),
      body: Center(
        child: StreamBuilder<List<TagModel>>(
            stream: xongo.getTagsTable,
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
                                    Text(snapshot.data[index].tag),
                                    InkWell(
                                        onTap: () async {
                                          TagModel item;
                                          item = TagModel();
                                          item.tag = snapshot.data[index].tag;
                                          tagDb.deleteTag(
                                              snapshot.data[index].tag);
                                          var bb = await tagDb.fetchMemos();
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    onRefresh: () async {
                      await Future<void>.delayed(Duration(seconds: 1));
                      xongo.fetchTableData();
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
