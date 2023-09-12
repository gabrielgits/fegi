import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_download_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([MockSpec<RepositoryLocalRelease>()])
@GenerateNiceMocks([MockSpec<RepositoryRemoteRelease>()])
@GenerateNiceMocks([MockSpec<ServiceFile>()])
import 'usecase_download_release_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalRelease();
  final repositoryRemote = MockRepositoryRemoteRelease();

  late UsecaseDownloadReleases usecaseDownloadVersion;

  setUp(() {
    usecaseDownloadVersion = UsecaseDownloadReleases(
      repositoryLocal: repositoryLocal,
      repositoryRemote: repositoryRemote,
      serviceFile: serviceFile,
    );
  });

  group('Download SdkVersion from host', () {
    test('Download All SdkVersions from local data without no exception',
        () async {

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: mockModelSdkRelease, exception: ExptDataNoExpt()));


      final result = await usecaseDownloadVersion.call(mockModelSdkRelease);
      expect(result.exptData, equals(ExptDataNoExpt()));
      expect(result.exptWeb, equals(ExptWebNoExpt()));
    });
    
    test('Download All SdkVersions from local data if has exception to download file',
        () async {

          List<int> emptyList = [];
      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: emptyList, exception: ExptWebGet()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: mockModelSdkRelease, exception: ExptDataNoExpt()));


      final result = await usecaseDownloadVersion.call(mockModelSdkRelease);
      expect(result.exptData, equals(ExptDataNoExpt()));
      expect(result.exptWeb, equals(ExptWebGet()));
    });

    test('Download All SdkVersions from local data if has exception to save file',
        () async {

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceExecute());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: mockModelSdkRelease, exception: ExptDataNoExpt()));


      final result = await usecaseDownloadVersion.call(mockModelSdkRelease);
      expect(result.exptData, isA<ExptDataUnknown>());
      expect(result.exptWeb, isA<ExptWebUnknown>());
    });

       test('Download All SdkVersions from local data if has exception to update release state',
        () async {

      when(
        repositoryRemote.downloadFile(any),
      ).thenAnswer((_) async => (data: [1, 2, 3], exception: ExptWebNoExpt()));

      when(
        serviceFile.saveFile(
            savePath: anyNamed('savePath'), fileData: anyNamed('fileData')),
      ).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: SdkReleaseModel.newObject(), exception: ExptDataSave()));


      final result = await usecaseDownloadVersion.call(mockModelSdkRelease);
      expect(result.exptData, equals(ExptDataSave()));
      expect(result.exptWeb, equals(ExptWebNoExpt()));
    });
     
  });

}
