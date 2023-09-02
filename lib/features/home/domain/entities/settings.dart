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

    Settings copyWith({
    int? id,
    int? globalSdkId,
    int? editor,
    String? projectsFolder,
    bool? windowsStart,
    bool? startMini,
    int? currentLang,
  }) {
    return Settings(
      id: id ?? this.id,
      globalSdkId: globalSdkId ?? this.globalSdkId,
      editor: editor ?? this.editor,
      projectsFolder: projectsFolder ?? this.projectsFolder,
      windowsStart: windowsStart ?? this.windowsStart,
      startMini: startMini ?? this.startMini,
      currentLang: currentLang ?? this.currentLang,
    );
  }

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
