
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/infra/datasources/data_http.dart';
import 'package:fegi/features/startup/domain/repositories/repository_remote_startup.dart';
import 'package:fegi/features/startup/infra/repositories/repository_remote_startup_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';

@GenerateNiceMocks([MockSpec<DataHttp>()])
import 'repository_remote_startup_impl_test.mocks.dart';

void main() {
  final mockDataHttp = MockDataHttp();
  late RepositoryRemoteStartup repository;

  setUp(() { 
    repository = RepositoryRemoteStartupImpl(mockDataHttp);
  });

  group('Repository Remote Startup', () {
    test('DownloadFile on server', () async {
      when(
        mockDataHttp.getData(any),
      ).thenAnswer((_) async => Future.value([1, 2, 3]));

      final result = await repository.downloadFile(mockModelSdkRelease.link);
      expect(result.data.length, greaterThan(0));
      expect(result.exception, ExptWebNoExpt());
    });

    test('DownloadFile fails on server', () async {
      when(
        mockDataHttp.getData(any),
      ).thenThrow(() async => throwsException);

      final result = await repository.downloadFile(mockModelSdkRelease.link);
      expect(result.data.length, 0);
      expect(result.exception, isA<ExptWebGet>());
    });
  });
}
