

import 'package:bform/bform.dart';

class BformObjImpl implements BformObj {
  @override
  final int id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String imagePath;

  BformObjImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  bool isSame(BformObj value) => id == value.id;
}

  final listLanguages = [
    BformObjImpl(
        id: 1,
        title: 'English',
        subtitle: 'en-US',
        imagePath: 'assets/images/flags/flag_en_us.png'),
    BformObjImpl(
        id: 2,
        title: 'Português',
        subtitle: 'pt-PT',
        imagePath: 'assets/images/flags/flag_pt_pt.png'),
  ];

  final listEditors = [
    BformObjImpl(
        id: 1,
        title: 'NotePad++',
        subtitle: 'pad',
        imagePath: 'assets/images/tools/pad.png'),
    BformObjImpl(
        id: 2,
        title: 'VS Code',
        subtitle: 'vscode',
        imagePath: 'assets/images/tools/vscode.png'),
    BformObjImpl(
        id: 3,
        title: 'Android Studio',
        subtitle: 'studio',
        imagePath: 'assets/images/tools/studio.png'),
  ];


  final listTools = [
    BformObjImpl(
        id: 1,
        title: 'GitHub Desktop',
        subtitle: 'https://desktop.github.com/',
        imagePath: 'assets/images/tools/github_desktop.png'),
    BformObjImpl(
        id: 2,
        title: 'VS Code',
        subtitle: 'https://code.visualstudio.com/',
        imagePath: 'assets/images/tools/vscode.png'),
    BformObjImpl(
        id: 3,
        title: 'Android Studio',
        subtitle: 'https://developer.android.com/',
        imagePath: 'assets/images/tools/studio.png'),
  ];


