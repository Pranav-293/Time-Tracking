import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/home/jobs/empty_jobs_page.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      List<T> items = snapshot.data;
      if (items.isEmpty) {
        return EmptyContent();
      }
      return _buildList(items);
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: "Something went wrong",
        message: "Can\'t load the data",
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => Divider(
        height: 0.5,
      ),
      itemBuilder: (context, index) {
        if(index==0|| index==items.length+1){
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
