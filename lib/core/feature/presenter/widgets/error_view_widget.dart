import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorViewWidget extends StatelessWidget {
  final String? error;

  const ErrorViewWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              tr('msn.error'),
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            Text(
              'Error: $error',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text('Close')),
          ],
        ),
      ),
    );
  }
}
