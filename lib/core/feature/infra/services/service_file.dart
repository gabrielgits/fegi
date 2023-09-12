import 'package:expt/expt.dart';

abstract class ServiceFile {
  ExptService deleteFile(String path);
  ExptService saveFile({required String savePath, required List<int> fileData});
  ExptService deleteFolder(String path);
  ({String path, ExptService exptService}) getAppPath();
}
