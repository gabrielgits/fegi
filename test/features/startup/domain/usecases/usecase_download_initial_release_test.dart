import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/startup/domain/repositories/repository_remote_startup.dart';
import 'package:fegi/features/startup/domain/usecases/usecase_download_initial_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<RepositoryRemoteStartup>(),
  MockSpec<ServiceFile>(),
])
import 'usecase_download_initial_release_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryRemote = MockRepositoryRemoteStartup();
  late UsecaseDownloadInitialReleases usecaseDownloadReleases;

  setUp(() {
    usecaseDownloadReleases = UsecaseDownloadInitialReleases(
        serviceFile: serviceFile, repositoryRemote: repositoryRemote);
  });

  group('Usecase Download Releases', () {
    test('Download initial sdk releases should return no exception', () async {
      when(repositoryRemote.downloadFile(any)).thenAnswer(
          (_) async => (exception: ExptWebNoExpt(), data: [1, 2, 3]));

      when(serviceFile.saveFile(
        savePath: anyNamed('savePath'),
        fileData: anyNamed('fileData'),
      )).thenReturn(ExptServiceNoExpt());

      final result = await usecaseDownloadReleases.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptWeb, ExptWebNoExpt());
    });

    test('Download initial sdk releases if downloadFile fails', () async {
      List<int> data = [];
      when(repositoryRemote.downloadFile(any)).thenAnswer(
          (_) async => (exception: ExptWebGet(), data: data));

      when(serviceFile.saveFile(
        savePath: anyNamed('savePath'),
        fileData: anyNamed('fileData'),
      )).thenReturn(ExptServiceNoExpt());

      final result = await usecaseDownloadReleases.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptWeb, ExptWebGet());
    });

    test('Download initial sdk releases if saveFile fails', () async {
      when(repositoryRemote.downloadFile(any)).thenAnswer(
          (_) async => (exception: ExptWebNoExpt(), data: [1, 2, 3]));

      when(serviceFile.saveFile(
        savePath: anyNamed('savePath'),
        fileData: anyNamed('fileData'),
      )).thenReturn(ExptServiceExecute());

      final result = await usecaseDownloadReleases.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptWeb, ExptWebNoExpt());
    });
 });
}
