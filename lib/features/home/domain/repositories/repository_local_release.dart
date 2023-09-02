import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';


abstract class RepositoryLocalRelease {
  Future<({int id, ExptData exception})> addRelease(SdkRelease release);
  Future<({int count, ExptData exception})> addListReleases(List<SdkRelease> releases);
  Future<({SdkRelease release, ExptData exception})> updateReleaseState({required int id, required int state});
  Future<({List<SdkRelease> releases, ExptData exception})> updateListReleaseState({required int fromState, required int toState});
  Future<({int id, ExptData exception})> deleteRelease(int id);
  Future<({int count, ExptData exception})> deleteAllRelease();
  Future<({List<SdkRelease> releases, ExptData exception})> loadListRelease();
  Future<({SdkRelease release, ExptData exception})>  loadGlobalRelease();
  Future<({SdkRelease release, ExptData exception})>  updateGlobalRelease(SdkRelease sdkVersion);
}
