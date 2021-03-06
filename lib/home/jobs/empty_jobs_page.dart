import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = "Nothing to show here",
    this.message = "Add a new item to get started",
  }) : super(key: key);
  final title;
  final message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black54,
              ),
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}
