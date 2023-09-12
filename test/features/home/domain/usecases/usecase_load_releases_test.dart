import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_load_releases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([MockSpec<RepositoryLocalRelease>()])
import 'usecase_load_releases_test.mocks.dart';

void main() {
  final repositoryLocal = MockRepositoryLocalRelease();
  late UsecaseLoadReleases usecaseLoadVersions;

  setUp(() {
    usecaseLoadVersions = UsecaseLoadReleases(repositoryLocal);
  });

  group('Test Load SdkVersions', () {

    test('Load SdkVersion from local data without no exception', () async {
      
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async => (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));
      
      final result = await usecaseLoadVersions.call();
      expect(result.exception, ExptDataNoExpt());
      expect(result.releases.length, greaterThan(0));
      expect(result.releases, mockListModelSdkRelease);
    });

    test('Load SdkVersion from local data if has exception to load list', () async {
      List<SdkRelease> emptyList = [];
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async => (releases: emptyList, exception: ExptDataLoad()));
      
      final result = await usecaseLoadVersions.call();
      expect(result.exception, ExptDataLoad());
      expect(result.releases.length, 0);
    });
  });
}
