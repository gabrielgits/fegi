
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

abstract class RepositoryRemoteRelease {
  Future<({List<SdkRelease> releases, ExptWeb exception})> getListReleases(String url);
  Future<({List<int> data, ExptWeb exception})>  downloadFile(String link);
}
