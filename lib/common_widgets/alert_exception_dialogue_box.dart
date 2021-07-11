import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alertExceptionDialogue({BuildContext context, String heading, String message}) {
    showCupertinoDialog(
    context: context,
    builder:(context)=> CupertinoAlertDialog(
      title: Text(heading),
      content: Text(message),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK")),
      ],
    ),
  );
}