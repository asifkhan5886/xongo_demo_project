import 'package:flutter/cupertino.dart';
import 'package:xongo_demo_app/databse/tags_list_table.dart';
import 'package:xongo_demo_app/models/response_model.dart';
import 'dart:async';
import 'package:xongo_demo_app/network/network_handler.dart';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Xongo {
  final _tagsController = BehaviorSubject<List<String>>();
  Stream<List<String>> get getTags => _tagsController.stream;
  MemoDbProvider tagDb = MemoDbProvider();

  final _tagsTableController = BehaviorSubject<List<TagModel>>();
  Stream<List<TagModel>> get getTagsTable => _tagsTableController.stream;

  void fetchXongoData() async {
    var networkHandler = NetworkHandler();
    var response = await networkHandler.callAPI();
    if (response != null) {
      List<String> data = List<String>.from(response.quote.tags);
      _tagsController.add(data);
      debugPrint('api success ' + data.toString());
    }
  }

  void fetchTableData() async {
    var bb = await tagDb.fetchMemos();
    _tagsTableController.add(bb);
  }
}

var xongo = Xongo();
