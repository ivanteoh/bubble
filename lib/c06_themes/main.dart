import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppDefaultTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
              headline4: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ),
          child: Builder(
            builder: (context) => Text(
              "Simple Text",
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    );
  }
}

class PlatformSpecificWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid 
      ? MaterialApp(
        theme: ThemeData(primaryColor: Colors.grey),
        home: Material( // note the material specific widget
          color: Colors.white,
          child: Center(
            child: Text(
              "Simple Material",
              // textDirection: TextDirection.ltr, don't need 
              // now thanks to materialapp
            ),
          ),
        ),
      ) : CupertinoApp(
        theme: CupertinoThemeData(primaryColor: 
          CupertinoColors.lightBackgroundGray
        ),
        home: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              "Simple Cupertino",
            ),
          ),
        ),
      );
  }
}
