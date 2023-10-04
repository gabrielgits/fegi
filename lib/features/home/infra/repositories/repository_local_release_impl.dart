import 'package:expt/expt.dart';
import 'package:feds/feds.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';

import '../../domain/repositories/repository_local_release.dart';

class RepositoryLocalReleaseImpl implements RepositoryLocalRelease {
  final FedsLocal datasource;
  final tableSettings = 'settings';
  final tableListSdkReleases = 'releases';
  final tableGlobalSdkRelease = 'global_release';
  const RepositoryLocalReleaseImpl(this.datasource);

  @override
  Future<({SdkRelease release, ExptData exception})> updateGlobalRelease(
      SdkRelease release) async {
    try {
      await datasource.update(
        table: tableGlobalSdkRelease,
        item: SdkReleaseModel.fromEntity(release).toMap(),
      );
      return (
        exception: ExptDataNoExpt(),
        release: release,
      );
    } catch (e) {
      return (
        exception: ExptDataSave(e.toString()),
        release: SdkReleaseModel.newObject(),
      );
    }
  }

  @override
  Future<({int count, ExptData exception})> addListReleases(
      List<SdkRelease> releases) async {
    try {
      final list = await datasource.getAll(tableListSdkReleases);
      list.addAll(releases.map((e) => SdkReleaseModel.fromEntity(e).toMap()));
      final count = await datasource.saveAll(
        table: tableListSdkReleases,
        items: list,
      );
      return (
        exception: ExptDataNoExpt(),
        count: count,
      );
    } catch (e) {
      return (
        exception: ExptDataSave(e.toString()),
        count: 0,
      );
    }
  }

  @override
  Future<({ExptData exception, int id})> addRelease(SdkRelease release) async {
    try {
      final list = await datasource.getAll(tableListSdkReleases);
      list.add(SdkReleaseModel.fromEntity(release).toMap());
      datasource.saveAll(table: tableListSdkReleases, items: list);
      return (
        exception: ExptDataNoExpt(),
        id: release.id,
      );
    } catch (e) {
      return (
        exception: ExptDataSave(e.toString()),
        id: 0,
      );
    }
  }

  @override
  Future<({int count, ExptData exception})> deleteAllRelease() async {
    try {
      final count = await datasource.deleteAll(tableListSdkReleases);
      return (
        exception: ExptDataNoExpt(),
        count: count,
      );
    } catch (e) {
      return (
        exception: ExptDataDelete(e.toString()),
        count: 0,
      );
    }
  }

  @override
  Future<({ExptData exception, int id})> deleteRelease(int id) async {
    try {
      final list = await datasource.getAll(tableListSdkReleases);
      list.removeWhere((element) => element['id'] == id);
      datasource.saveAll(table: tableListSdkReleases, items: list);
      return (
        exception: ExptDataNoExpt(),
        id: id,
      );
    } catch (e) {
      return (
        exception: ExptDataDelete(e.toString()),
        id: 0,
      );
    }
  }

  @override
  Future<({ExptData exception, SdkRelease release})> loadGlobalRelease() async {
    try {
      final item =
          await datasource.getItem(table: tableGlobalSdkRelease, id: 0);
      final model = SdkReleaseModel.fromMap(item);
      return (
        exception: ExptDataNoExpt(),
        release: model,
      );
    } catch (e) {
      return (
        exception: ExptDataLoad(e.toString()),
        release: SdkReleaseModel.newObject(),
      );
    }
  }

  @override
  Future<({ExptData exception, List<SdkRelease> releases})> loadListRelease() async {
    try {
      final items = await datasource.getAll(tableListSdkReleases);
      final list = items.map((e) => SdkReleaseModel.fromMap(e)).toList();
      return (
        exception: ExptDataNoExpt(),
        releases: list,
      );
    } catch (e) {
      List<SdkRelease> items = [];
      return (
        exception: ExptDataLoad(e.toString()),
        releases: items,
      );
    }
  }

  @override
  Future<({ExptData exception, SdkRelease release})> updateReleaseState(
      {required int id, required int state}) async {
    try {
      final items = await datasource.getAll(tableListSdkReleases);
      final list = items.map((e) {
        if (e['id'] == id) {
          e['state'] = state;
        }
        return e;
      }).toList();
      datasource.saveAll(table: tableListSdkReleases, items: list);
      return (
        exception: ExptDataNoExpt(),
        release: SdkReleaseModel.fromMap(list.first),
      );
    } catch (e) {
      return (
        exception: ExptDataSave(e.toString()),
        release: SdkReleaseModel.newObject(),
      );
    }
  }

  @override
  Future<({List<SdkRelease> releases, ExptData exception})>
      updateListReleaseState(
          {required int fromState, required int toState}) async {
    try {
      final items = await datasource.getAll(tableListSdkReleases);
      final list = items.map((e) {
        if (e['state'] == fromState) {
          e['state'] = toState;
        }
        return e;
      }).toList();
      datasource.saveAll(table: tableListSdkReleases, items: list);
      final releases = list.map((e) => SdkReleaseModel.fromMap(e)).toList();
      return (
        exception: ExptDataNoExpt(),
        releases: releases,
      );
    } catch (e) {
      List<SdkRelease> releases = [];
      return (
        exception: ExptDataSave(e.toString()),
        releases: releases,
      );
    }
  }
}
