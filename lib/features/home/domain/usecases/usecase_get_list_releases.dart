import 'package:expt/expt.dart';
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../repositories/repository_remote_release.dart';

class UsecaseGetListReleases {
  final RepositoryRemoteRelease repositoryRemote;
  const UsecaseGetListReleases(this.repositoryRemote);

  Future<({List<SdkRelease> releases, ExptWeb exception})> call() async {
    final resultWeb = await repositoryRemote.getListReleases(App.urlGoogleWinApi);

    if (resultWeb.exception != ExptWebNoExpt() || resultWeb.releases.isEmpty) {
      return resultWeb;
    }

    final listFiltered = resultWeb.releases.where((element) {
      DateTime dt1 = DateTime.parse(element.date);
      DateTime dt2 = DateTime.parse("2021-03-02T17:51:02.649408Z");
      return element.channel == 'stable' && dt1.compareTo(dt2) > 0;
    }).toList();

    return (
      releases: listFiltered,
      exception: ExptWebNoExpt(),
    );
  }
}
