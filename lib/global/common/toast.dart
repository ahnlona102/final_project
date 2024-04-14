import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:IntelliHome/constants/app_colors.dart';

void showToast({
  required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.black.withOpacity(0.3),
    textColor: Colors.white,
    fontSize: 16.0
  );
}