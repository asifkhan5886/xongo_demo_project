import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utility {
  static void showToast(String msg, Toast length) {
    if (msg != null && msg.replaceAll(' ', '').isNotEmpty)
      Fluttertoast.showToast(
          msg: msg,
          toastLength: length,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
  }
}
