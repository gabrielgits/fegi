import 'dart:io';

import 'package:expt/expt.dart';

import '../../infra/services/service_file.dart';

class ServiceFileImpl implements ServiceFile {
  @override
  ExptService deleteFile(String path) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync(recursive: true);
        return ExptServiceNoExpt();
      }
      return ExptServiceLoad('File not found');
    } catch (e) {
      return ExptServiceExecute(e.toString());
    }
  }

  @override
  ExptService deleteFolder(String path) {
    try {
      final dir = Directory(path);
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
        return ExptServiceNoExpt();
      }
      return ExptServiceLoad('Folder not found');
    } catch (e) {
      rethrow;
    }
  }

  @override
  ExptService saveFile({
    required String savePath,
    required List<int> fileData,
  }) {
    try {
      final file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(fileData);
      file.close();
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute(e.toString());
    }
  }

  @override
  ({String path, ExptService exptService}) getAppPath() {
    String path = '/';
    try {
      final dir = Directory.current;
      if (dir.existsSync()) {
        path = dir.path;
        return (path: path, exptService: ExptServiceNoExpt());
      }
      return (
        path: path,
        exptService: ExptServiceUnknown('Directory not found')
      );
    } catch (e) {
      return (path: '', exptService: ExptServiceExecute(e.toString()));
    }
  }
}
