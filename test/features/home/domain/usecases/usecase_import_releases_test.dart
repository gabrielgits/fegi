import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_import_releases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([MockSpec<RepositoryLocalRelease>()])
import 'usecase_import_releases_test.mocks.dart';

void main() {
  final repositoryLocal = MockRepositoryLocalRelease();
  late UsecaseImportReleases usecaseImportVersions;

  setUp(() {
    usecaseImportVersions = UsecaseImportReleases(repositoryLocal);
  });

  group('UseCase Import Releases', () {

    test('Save the list of SdkVersions into local without no exception',
        () async {
      when(
        repositoryLocal.addListReleases(any),
      ).thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      final result = await usecaseImportVersions.call(mockListModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.count, greaterThan(0));
    });

    test('Save the list of SdkVersions into local when add release to list fails',
        () async {
      when(
        repositoryLocal.addListReleases(any),
      ).thenAnswer((_) async => (count: 0, exception: ExptDataSave()));

      final result = await usecaseImportVersions.call(mockListModelSdkRelease);
      expect(result.exception, ExptDataSave());
      expect(result.count, 0);
    });


  });
}
