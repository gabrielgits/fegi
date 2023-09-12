import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

@override
Future<bool> openUrl(String link) async {
  final Uri url = Uri.parse(link);
  try {
   return await launchUrl(url);
  }
 on PlatformException {
   return false;
 }
}
