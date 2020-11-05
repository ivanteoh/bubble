import 'package:flutter/material.dart';

import 'item_model.dart';

/// Widget for displaying detailed info of [ItemModel]
class ItemDetailsPage extends StatefulWidget {
 final ItemModel model;

 const ItemDetailsPage(this.model, {Key key}) : super(key: key);

 @override
 _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
 @override
 Widget build(BuildContext context) {
   return widget.model.widget;
 }
}
