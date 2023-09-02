
import 'package:fegi/core/states/sdk_state.dart';

import '../../domain/entities/sdk_release.dart';

class SdkReleaseModel extends SdkRelease {
  const SdkReleaseModel({
    required super.id,
    required super.version,
    required super.architecture,
    required super.date,
    required super.dartVersion,
    required super.state,
    required super.changeLog,
    required super.link,
    required super.file,
    required super.channel,
  });

  factory SdkReleaseModel.fromMap(Map<String, dynamic> map) {
    String archive = map['archive'] ?? '';
    return SdkReleaseModel(
      id: map['id'] ?? 0,
      version: map['version'],
      architecture: map['architecture'] ?? map['dart_sdk_arch'] ?? '',
      date: map['date'] ?? map['release_date'] ?? '',
      dartVersion: map['dartVersion'] ?? map['dart_sdk_version'] ?? '',
      state: map['state'] ?? SdkState.available,
      changeLog: map['changeLog'] ?? '',
      link: map['link'] ?? archive,
      file: map['file'] ?? archive.split('/').last,
      channel: map['channel'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['architecture'] = architecture;
    data['date'] = date;
    data['dartVersion'] = dartVersion;
    data['state'] = state;
    data['changeLog'] = changeLog;
    data['link'] = link;
    data['file'] = file;
    data['channel'] = channel;
    return data;
  }

  factory SdkReleaseModel.fromEntity(SdkRelease sdkVersion) {
    return SdkReleaseModel(
      id: sdkVersion.id,
      version: sdkVersion.version,
      architecture: sdkVersion.architecture,
      date: sdkVersion.date,
      dartVersion: sdkVersion.dartVersion,
      state: sdkVersion.state,
      changeLog: sdkVersion.changeLog,
      link: sdkVersion.link,
      file: sdkVersion.file,
      channel: sdkVersion.channel,
    );
  }

    factory SdkReleaseModel.newObject() {
    return const SdkReleaseModel(
      id: 0,
      version: '',
      architecture: '',
      date: '',
      dartVersion: '',
      state: SdkState.unknown,
      changeLog: '',
      link: '',
      file: '',
      channel: '',
    );
  }
}
