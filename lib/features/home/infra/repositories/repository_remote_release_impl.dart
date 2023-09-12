
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/datasources/data_http.dart';
import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';

import '../../domain/repositories/repository_remote_release.dart';

class RepositoryRemoteReleaseImpl implements RepositoryRemoteRelease {
  final DataHttp datasource;
  const RepositoryRemoteReleaseImpl(this.datasource);

  @override
  Future<({List<int> data, ExptWeb exception})> downloadFile(
      String link) async {
    try {
      return (
        data: await datasource.getData(link),
        exception: ExptWebNoExpt(),
      );
    } catch (e) {
      List<int> list = [];
      return (
        data: list,
        exception: ExptWebGet(e.toString()),
      );
    }
  }

  @override
  Future<({List<SdkRelease> releases, ExptWeb exception})> getListReleases(String url) async {
    List<SdkRelease> releases = [];
    try {
      final result = await datasource.get(url);
      final items = result['releases'] as List;
      for (var item in items) {
        releases.add(SdkReleaseModel.fromMap(item));
      }
      return (
        releases: releases,
        exception: ExptWebNoExpt(),
      );
    } catch (e) {
      List<SdkRelease> list = [];
      return (
        releases: list,
        exception: ExptWebGet(e.toString()),
      );
    }
  }
}
