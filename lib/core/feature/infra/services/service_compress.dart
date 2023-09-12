
import 'package:expt/expt.dart';

abstract class ServiceCompress {
  Future<ExptService> unzip({required String sourcePath, required String destinationPath});
  Future<ExptService> zip({required String sourcePath, required String destinationPath});
}