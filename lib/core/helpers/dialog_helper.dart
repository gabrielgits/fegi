

import 'package:flutter/material.dart';


Future<bool> dialogHelper({
  required BuildContext context,
  required String title,
  required Widget content,
  required String yesButton,
  required String noButton,
}) async {
  bool confirmation = false;
  await showDialog(
    context: context,
    barrierDismissible : false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content,
      ),
      actions: <Widget>[
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.deepOrange),
          icon: const Icon(Icons.cancel),
          onPressed: () {
            confirmation = false;
            Navigator.of(context).pop();
          },
          label: Text(noButton),
        ),
        const SizedBox(width: 20),
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
          icon: const Icon(Icons.done),
          onPressed: () {
            confirmation = true;
            Navigator.of(context).pop();
          },
          label: Text(yesButton),
        ),
      ],
    ),
  );

  return confirmation;
}

