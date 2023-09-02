import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/infra/datasources/data_http.dart';
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart';
import 'package:fegi/features/home/infra/repositories/repository_remote_release_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';

@GenerateNiceMocks([MockSpec<DataHttp>()])
import 'repository_remote_home_impl_test.mocks.dart';

void main() {
  final mockDataHttp = MockDataHttp();
  late RepositoryRemoteRelease repository;

  setUp(() {
    repository = RepositoryRemoteReleaseImpl(mockDataHttp);
  });

  group('Repository Remote Home Download', () {
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

  group('Repository Remote Home Get List', () {
    final listMapSdkReleases =
        mockListModelSdkRelease.map((e) => e.toMap()).toList();

    test('Download List on server', () async {
      when(
        mockDataHttp.get(any),
      ).thenAnswer((_) async => {'releases': listMapSdkReleases});

      final result = await repository.getListReleases('link_to_server');
      expect(result.releases.length, greaterThan(0));
      expect(result.releases, mockListModelSdkRelease);
      expect(result.exception, ExptWebNoExpt());
    });

    test('DownloadFile fails on server', () async {
      when(
        mockDataHttp.get(any),
      ).thenThrow(() async => throwsException);

      final result = await repository.getListReleases('link_to_server');
      expect(result.releases.length, 0);
      expect(result.exception, isA<ExptWebGet>());
    });
  });
}
