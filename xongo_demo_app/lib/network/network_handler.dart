import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:xongo_demo_app/models/response_model.dart';

class NetworkHandler {
  ///As there is only one API call in the app, keeping base url same

  String _baseUrl = 'https://favqs.com/api/qotd';

  Future<DataModel> callAPI() async {
    Map<String, dynamic> responseJson;

    var response = await http.get(
      _baseUrl,
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 60));

    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      var mainResponse = DataModel.fromJson(responseJson);
      debugPrint('api success ' + responseJson.toString());
      return mainResponse;
    }
    debugPrint('api failed');
    return null;
  }
}
