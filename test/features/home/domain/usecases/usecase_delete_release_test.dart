import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_delete_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<ServiceFile>(),
  MockSpec<RepositoryLocalRelease>(),
])
import 'usecase_delete_release_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalRelease();
  late UsecaseDeleteRelease usecaseDeleteVersion;

  setUp(() {
    usecaseDeleteVersion = UsecaseDeleteRelease(
      repositoryLocal: repositoryLocal,
      serviceFile: serviceFile,
    );
  });

  group('Home Usecase Delete Release', () {
    test('Delete SdkVersion from local data without no exception', () async {
      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.updateReleaseState(
              id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async =>
              (release: mockModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseDeleteVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceNoExpt());
    });

    test('Delete SdkVersion from local data if has exception to delete file',
        () async {
      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceExecute());

      when(repositoryLocal.updateReleaseState(
              id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async =>
              (release: mockModelSdkRelease, exception: ExptDataNoExpt()));


      final result = await usecaseDeleteVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceExecute());
    });

    test('Delete SdkVersion from local data if has exception to delete data',
        () async {
      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceNoExpt());


      when(repositoryLocal.updateReleaseState(
              id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async =>
              (release: mockModelSdkRelease, exception: ExptDataDelete()));

      final result = await usecaseDeleteVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataDelete());
      expect(result.exptService, ExptServiceNoExpt());
    });
  });
}
