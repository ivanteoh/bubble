import 'package:flutter/material.dart';
import 'package:my_app/item_details_page.dart';
import 'package:my_app/item_model.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  // Hard-coded list of [ItemModel] to be displayed on our page.
  final List<ItemModel> _items = [
    ItemModel(0, Icons.account_balance, 'Balance', 'Some info'),
    ItemModel(1, Icons.account_balance_wallet, 'Balance wallet', 'Some info'),
    ItemModel(2, Icons.alarm, 'Alarm', 'Some info'),
    ItemModel(3, Icons.my_location, 'My location', 'Some info'),
    ItemModel(4, Icons.laptop, 'Laptop', 'Some info'),
    ItemModel(5, Icons.backup, 'Backup', 'Some info'),
    ItemModel(6, Icons.settings, 'Settings', 'Some info'),
    ItemModel(7, Icons.call, 'Call', 'Some info'),
    ItemModel(8, Icons.restore, 'Restore', 'Some info'),
    ItemModel(9, Icons.camera_alt, 'Camera', 'Some info'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          // Widget which creates [ItemWidget] in scrollable list.
          itemCount: _items.length, // Number of widget to be created.
          itemBuilder: (context,
                  itemIndex) => // Builder function for every item with index.
              ItemWidget(_items[itemIndex], () {
            _onItemTap(context, itemIndex);
          }),
        ));
  }

  // Method which uses BuildContext to push (open) new MaterialPageRoute (representation of the screen in Flutter navigation model) with ItemDetailsPage (StateFullWidget with UI for page) in builder.
  _onItemTap(BuildContext context, int itemIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ItemDetailsPage(_items[itemIndex])));
  }
}

// StatelessWidget with UI for our ItemModel-s in ListView.
class ItemWidget extends StatelessWidget {
  const ItemWidget(this.model, this.onItemTap, {Key key}) : super(key: key);

  final ItemModel model;
  final Function onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Enables taps for child and add ripple effect when child widget is long pressed.
      onTap: onItemTap,
      child: ListTile(
        // Useful standard widget for displaying something in ListView.
        leading: Hero(tag: model.id, child: Icon(model.icon)),
        title: Text(model.title),
      ),
    );
  }
}
