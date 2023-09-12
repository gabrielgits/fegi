import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_uninstall_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([MockSpec<RepositoryLocalRelease>()])
@GenerateNiceMocks([MockSpec<ServiceFile>()])
import 'usecase_uninstall_release_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalRelease();
  late UsecaseUninstallRelease usecaseUninstallVersion;

  setUp(() {
    usecaseUninstallVersion = UsecaseUninstallRelease(
      repositoryLocal: repositoryLocal,
      serviceFile: serviceFile,
    );
  });

  group('Home Usecase Uninstall Release', () {
    test(
        'Uninstall current SdkVersion on local environment without no exception',
        () async {

      when(serviceFile.deleteFolder(any)).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: mockModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseUninstallVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceNoExpt());
    });

    test(
        'Uninstall current SdkVersion on local environment if has exception to delete folder',
        () async {

      when(serviceFile.deleteFolder(any)).thenReturn(ExptServiceExecute());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: mockModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseUninstallVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceExecute());
    });

    test(
        'Uninstall current SdkVersion on local environment if has exception to update state',
        () async {

      when(serviceFile.deleteFolder(any)).thenReturn(ExptServiceNoExpt());

      when(
        repositoryLocal.updateReleaseState(
            id: anyNamed('id'), state: anyNamed('state')),
      ).thenAnswer((_) async =>
          (release: SdkReleaseModel.newObject(), exception: ExptDataSave()));

      final result = await usecaseUninstallVersion.call(mockModelSdkRelease);
      expect(result.exptData, ExptDataSave());
      expect(result.exptService, ExptServiceNoExpt());
    });
  });
}
