import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final int id;
  final int globalSdkId;
  final int editor;
  final String projectsFolder;
  final bool windowsStart;
  final bool startMini;
  final int currentLang;

  const Settings({
    required this.id,
    required this.globalSdkId,
    required this.editor,
    required this.projectsFolder,
    required this.windowsStart,
    required this.startMini,
    required this.currentLang,
  });

  @override
  List<Object?> get props => [
        id,
        globalSdkId,
        editor,
        projectsFolder,
        windowsStart,
        startMini,
        currentLang,
      ];
}
