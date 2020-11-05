import 'package:flutter/material.dart';

import 'items_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examples',
      home: ItemsListPage(title: 'Flutter Examples'),
    );
  }
}
