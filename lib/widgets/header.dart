import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? "Splash" : titleText,
      style: TextStyle(
        color: Colors.black,
        fontFamily: isAppTitle ? "Billabong" : "Allura",
        fontSize: 25.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Colors.grey,
  );
}
