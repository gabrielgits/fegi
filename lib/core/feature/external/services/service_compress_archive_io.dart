import 'dart:io';
import 'package:archive/archive_io.dart';

import 'package:expt/expt.dart';
import '../../infra/services/service_compress.dart';

class ServiceCompressArchiveIo implements ServiceCompress {


  @override
  Future<ExptService> unzip({
    required String sourcePath,
    required String destinationPath,
  }) async {
    // Read the Zip file from disk.
    try {
      final zipFile = File(sourcePath);
      if (!zipFile.existsSync()) {
        return ExptServiceLoad('File $sourcePath not found');
      }
      final bytes = await zipFile.readAsBytes();
      // Decode the Zip file
      final Archive archive = ZipDecoder().decodeBytes(bytes);
      // Extract the contents of the Zip archive to extractToPath.
      for (final ArchiveFile file in archive) {
        final String filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File('$destinationPath/$filename')
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          // it should be a directory
          Directory('$destinationPath/$filename').create(recursive: true);
        }
      }
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute(e.toString());
    }
  }

  @override
  Future<ExptService> zip({
    required String sourcePath,
    required String destinationPath,
  }) async {
    try {
      // Read the Zip file from disk.
      var encoder = ZipFileEncoder();
      final dir = Directory(sourcePath);
      if (!dir.existsSync()) {
        return ExptServiceLoad('File $sourcePath not found');
      }
      // Write the Zip file to disk.
      encoder.zipDirectory(dir, filename: destinationPath);
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute(e.toString());
    }
  }
}
