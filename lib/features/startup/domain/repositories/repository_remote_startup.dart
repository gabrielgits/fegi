import 'package:fegi/core/exceptions/expt_web.dart';

abstract class RepositoryRemoteStartup {
  Future<({List<int> data, ExptWeb exception})> downloadFile(String link);
}
