import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/helpers/open_url.dart';
import 'package:flutter/material.dart';

import '../controllers/form_lists.dart';

class ToolsWidget extends StatelessWidget {
  const ToolsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    
    return SizedBox(
      height: 250,
      width: 300,
      child: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
      for (final tool in listTools)
            Card(
              child: ListTile(
                  leading: Image.asset(tool.imagePath),
                  title: Text(tool.title),
                  subtitle: BformButton(
                      label:tr('btn.download'),
                      icon: Icons.arrow_outward,
                      onPressed: () async => await openUrl(tool.subtitle))),
            ),
          ]),
    );
        
  }
  
}
