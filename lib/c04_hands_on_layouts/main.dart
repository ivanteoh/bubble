import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// import 'app_theme.dart';
import 'favor.dart';
import 'friend.dart';
// import 'mock_values.dart';

class FavorsPage extends StatelessWidget {
  // using mock values from mock_favors dart file for now
  final List<Favor> pendingAnswerFavors;
  final List<Favor> acceptedFavors;
  final List<Favor> completedFavors;
  final List<Favor> refusedFavors;

  FavorsPage({
    Key key,
    this.pendingAnswerFavors,
    this.acceptedFavors,
    this.completedFavors,
    this.refusedFavors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your favors"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Doing"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Refused"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FavorsList(title: "Pending Requests", favors: pendingAnswerFavors),
            FavorsList(title: "Doing", favors: acceptedFavors),
            FavorsList(title: "Completed", favors: completedFavors),
            FavorsList(title: "Refused", favors: refusedFavors),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Ask a favor',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  //  ... fields, build method and others
  Widget _buildCategoryTab(String title) {
    return Tab(
      child: Text(title),
    );
  } // for brevity

}

class FavorsList extends StatelessWidget {
  final String title;
  final List<Favor> favors;

  const FavorsList({Key key, this.title, this.favors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          child: Text(title),
          padding: EdgeInsets.only(top: 16.0),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: favors.length,
            itemBuilder: (BuildContext context, int index) {
              final favor = favors[index];
              return FavorCardItem(favor: favor);
            },
          ),
        ),
      ],
    );
  }
}

class FavorCardItem extends StatelessWidget {
  final Favor favor;

  const FavorCardItem({Key key, this.favor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(favor.uuid),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        child: Column(
          children: <Widget>[
            _itemHeader(favor),
            Text(favor.description),
            _itemFooter(favor)
          ],
        ),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }

  Row _itemHeader(Favor favor) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            favor.friend.photoURL,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("${favor.friend.name} asked you to... "),
          ),
        )
      ],
    );
  }

  Widget _itemFooter(Favor favor) {
    if (favor.isCompleted) {
      final format = DateFormat();
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        alignment: Alignment.centerRight,
        child: Chip(
          label: Text(
            "Completed at: ${format.format(favor.completed)}",
          ),
        ),
      );
    }
    if (favor.isRequested) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("Refuse"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Do"),
            onPressed: () {},
          )
        ],
      );
    }
    if (favor.isDoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("give up"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("complete"),
            onPressed: () {},
          )
        ],
      );
    }

    return Container();
  }
}

class RequestFavorPage extends StatelessWidget {
  final List<Friend> friends;

  RequestFavorPage({Key key, this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requesting a favor"),
        leading: CloseButton(),
        actions: <Widget>[
          FlatButton(
            child: Text("SAVE"),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField<Friend>(
            onChanged: (friend) {},
            items: friends
                .map(
                  (f) => DropdownMenuItem<Friend>(
                    child: Text(f.name),
                  ),
                )
                .toList(),
          ),
          Container(
            height: 16.0,
          ),
          Text("Favor description:"),
          TextFormField(
            maxLines: 5,
            inputFormatters: [LengthLimitingTextInputFormatter(200)],
          ),
          Container(
            height: 16.0,
          ),
          Text("Due Date:"),
          DateTimeField(
            // inputType: InputType.both,
            format: DateFormat("yyyy-MM-dd HH:mm"),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
          ),
        ],
      ),
    );
  }
}
