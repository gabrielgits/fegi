import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_download_all_releases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([MockSpec<RepositoryLocalRelease>()])
@GenerateNiceMocks([MockSpec<RepositoryRemoteRelease>()])
@GenerateNiceMocks([MockSpec<ServiceFile>()])
import 'usecase_download_all_releases_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalHome();
  final repositoryRemote = MockRepositoryRemoteHome();
  late UseCaseDownloadAllReleases usecaseDownloadAllVersion;

  setUp(() {
    usecaseDownloadAllVersion = UseCaseDownloadAllReleases(
      repositoryLocal: repositoryLocal,
      repositoryRemote: repositoryRemote,
      serviceFile: serviceFile,
    );
  });

  group('Home UseCase DownloadAllReleases', () {
    test('Download All SdkVersions from local data without no exception',
        () async {
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateListReleaseState(
            fromState: anyNamed('fromState'), toState: anyNamed('toState')),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseDownloadAllVersion.call();
      expect(result.exptData, equals(ExptDataNoExpt()));
      expect(result.exptWeb, equals(ExptWebNoExpt()));
    });

    test(
        'Download All SdkVersions from local data if load list release has exception',
        () async {
      List<SdkRelease> emptyList = [];
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer(
          (_) async => (releases: emptyList, exception: ExptDataLoad()));

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateListReleaseState(
            fromState: anyNamed('fromState'), toState: anyNamed('toState')),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseDownloadAllVersion.call();
      expect(result.exptData, equals(ExptDataLoad()));
      expect(result.exptWeb, equals(ExptWebNoExpt()));
    });

    test(
        'Download All SdkVersions from local data if download file has exception',
        () async {
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      List<int> emptyList = [];
      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: emptyList, exception: ExptWebGet()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateListReleaseState(
            fromState: anyNamed('fromState'), toState: anyNamed('toState')),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseDownloadAllVersion.call();
      expect(result.exptData, equals(ExptDataNoExpt()));
      expect(result.exptWeb, equals(ExptWebGet()));
    });

    test('Download All SdkVersions from local data if save file has exception',
        () async {
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceExecute());

      when(
        repositoryLocal.updateListReleaseState(
            fromState: anyNamed('fromState'), toState: anyNamed('toState')),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseDownloadAllVersion.call();
      expect(result.exptData, isA<ExptDataUnknown>());
      expect(result.exptWeb, isA<ExptWebUnknown>());
    });

    test(
        'Download All SdkVersions from local data if update list release state has exception',
        () async {
      when(
        repositoryLocal.loadListRelease(),
      ).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      List<SdkRelease> emptyList = [];
      when(
        repositoryLocal.updateListReleaseState(
            fromState: anyNamed('fromState'), toState: anyNamed('toState')),
      ).thenAnswer(
          (_) async => (releases: emptyList, exception: ExptDataSave()));

      final result = await usecaseDownloadAllVersion.call();
      expect(result.exptData, equals(ExptDataSave()));
      expect(result.exptWeb, equals(ExptWebNoExpt()));
    });
  });
}
