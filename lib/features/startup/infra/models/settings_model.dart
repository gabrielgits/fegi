import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.id,
    required super.globalSdkId,
    required super.editor,
    required super.projectsFolder,
    required super.windowsStart,
    required super.startMini,
    required super.currentLang,
  });

  factory SettingsModel.newObject() {
    return const SettingsModel(
      id: 0,
      globalSdkId: 0,
      editor: 0,
      projectsFolder: '',
      windowsStart: false,
      startMini: false,
      currentLang: 0,
    );
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'],
      globalSdkId: map['globalSdkId'],
      editor: map['editor'],
      projectsFolder: map['projectsFolder'],
      windowsStart: map['windowsStart'],
      startMini: map['startMini'],
      currentLang: map['currentLang'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['globalSdkId'] = globalSdkId;
    data['editor'] = editor;
    data['projectsFolder'] = projectsFolder;
    data['windowsStart'] = windowsStart;
    data['startMini'] = startMini;
    data['currentLang'] = currentLang;

    return data;
  }

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      id: settings.id,
      globalSdkId: settings.globalSdkId,
      editor: settings.editor,
      projectsFolder: settings.projectsFolder,
      windowsStart: settings.windowsStart,
      startMini: settings.startMini,
      currentLang: settings.currentLang,
    );
  }
}
