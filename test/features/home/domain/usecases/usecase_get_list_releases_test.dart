import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_get_list_releases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';

@GenerateNiceMocks([MockSpec<RepositoryRemoteRelease>()])
import 'usecase_get_list_releases_test.mocks.dart';

void main() {

  final repositoryRemote = MockRepositoryRemoteRelease();
  late UsecaseGetListReleases usecaseGetVersions;

  setUp(() {
    usecaseGetVersions = UsecaseGetListReleases(repositoryRemote);
  });

  group('Home Usecase GetList Releases', () {

    test('Download the list of SdkVersions from host without no exception',
        () async {
      when(
        repositoryRemote.getListReleases(any),
      ).thenAnswer((_) async => (releases: mockListModelSdkRelease, exception: ExptWebNoExpt()));

      final result = await usecaseGetVersions.call();
      expect(result.releases.length, greaterThan(0));
      expect(result.releases, mockListModelSdkRelease);
      expect(result.exception, ExptWebNoExpt());
    });

    test('Download the list of SdkVersions from host when get list fails',
        () async {
          List<SdkRelease> emptyList = [];
      when(
        repositoryRemote.getListReleases(any),
      ).thenAnswer((_) async => (releases: emptyList, exception: ExptWebGet()));

      final result = await usecaseGetVersions.call();
      expect(result.releases.length, 0);
      expect(result.exception, ExptWebGet());
    });
  });
}