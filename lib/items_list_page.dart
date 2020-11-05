import 'package:flutter/material.dart';

import 'c04_hands_on_layouts/main.dart';
import 'c04_hands_on_layouts/mock_values.dart';
import 'c05_gestures/doubletap_event_example.dart';
import 'c05_gestures/drag_event_example.dart';
import 'c05_gestures/pan_event_example.dart';
import 'c05_gestures/press_and_hold_event_example.dart';
import 'c05_gestures/scale_event_example.dart';
import 'c05_gestures/tap_event_example.dart';
import 'c05_hands_on_input/main.dart';
import 'c05_input/main.dart';
import 'item_details_page.dart';
import 'item_model.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {

// Hard-coded list of [ItemModel] to be displayed on our page.
 final List<ItemModel> _items = [
   ItemModel('c04', 'Hands On Layouts', FavorsPage(
        pendingAnswerFavors: mockPendingFavors,
        completedFavors: mockCompletedFavors,
        refusedFavors: mockRefusedFavors,
        acceptedFavors: mockDoingFavors,
      )),
  ItemModel('c05_input_a', 'Input Controller Examples Widget', InputControllerExamplesWidget()),
  ItemModel('c05_input_b', 'Input Form Field Examples Widget', InputFormFieldExamplesWidget()),
  ItemModel('c05_input_c', 'Input Form Examples Widget', InputFormExamplesWidget()),
  ItemModel('c05_input_d', 'Input Form Inherited State Examples Widget', InputFormInheritedStateExamplesWidget()),
  ItemModel('c05_input_e', 'Custom Input State Examples Widget', CustomInputStateExamplesWidget()),
  ItemModel('c05_input_e', 'Custom Input State Examples Widget', CustomInputStateExamplesWidget()),
  ItemModel('c05_gesture_a', 'Tap Widget Example Widget', TapWidgetExample()),
  ItemModel('c05_gesture_b', 'Double Tap Widget Example Widget', DoubleTapWidgetExample()),
  ItemModel('c05_gesture_c', 'Press And Hold Widget Example Widget', PressAndHoldWidgetExample()),
  ItemModel('c05_gesture_d', 'Vertical Drag Widget Example Widget', VerticalDragWidgetExample()),
  ItemModel('c05_gesture_e', 'Horizontal Drag Widget Example Widget', HorizontalDragWidgetExample()),
  ItemModel('c05_gesture_f', 'Pan Widget Example Widget', PanWidgetExample()),
  ItemModel('c05_gesture_g', 'Scale Widget Example Widget', ScaleWidgetExample()),
  ItemModel('c05_hands_on_input', 'Hands On Input Favors Page', HandsOnInputFavorsPage()),
 ];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         title: Text(widget.title),
       ),
       body: ListView.builder( // Widget which creates [ItemWidget] in scrollable list.
         itemCount: _items.length, // Number of widget to be created.
         itemBuilder: (context, itemIndex) => // Builder function for every item with index.
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
   return InkWell( // Enables taps for child and add ripple effect when child widget is long pressed.
     onTap: onItemTap,
     child: ListTile( // Useful standard widget for displaying something in ListView.
       title: Text(model.title),
     ),
   );
 }
}
