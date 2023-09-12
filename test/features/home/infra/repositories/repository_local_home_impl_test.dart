import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/core/states/sdk_state.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/infra/repositories/repository_local_release_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';

@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'repository_local_home_impl_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalRelease repository;

  setUp(() {
    repository = RepositoryLocalReleaseImpl(mockDataLocal);
  });

      final listMapSdkReleases =
        mockListModelSdkRelease.map((e) => e.toMap()).toList();

  group('Get SdkReleases from repository', () {
    

    test('loadCurrentReleases should return Model', () async {
      
      when(
        mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockModelSdkRelease.toMap());

      final result = await repository.loadGlobalRelease();
      expect(result.exception, ExptDataNoExpt());
      expect(result.release, mockModelSdkRelease);
    });

    test('loadCurrentReleases when should return exception if getItem fails',
        () async {
      when(
        mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repository.loadGlobalRelease();
      expect(result.exception, isA<ExptDataLoad>());
      expect(result.release.id, 0);
    });

    test('loadReleasess should return list of Model', () async {

    when(
      mockDataLocal.getAll(any),
    ).thenAnswer((_) async => listMapSdkReleases);

      final result = await repository.loadListRelease();
      expect(result.exception, ExptDataNoExpt());
      expect(result.releases.length, greaterThan(0));
    });

    test('loadReleasess should return list of Model', () async {
      when(
        mockDataLocal.getAll(any),
      ).thenThrow((_) async => throwsException);

      final result = await repository.loadListRelease();
      expect(result.exception, isA<ExptDataLoad>());
      expect(result.releases.length, 0);
    });
  });

  group('Add SdkReleases in repository', () {

    test('addReleases should return SdkReleases id', () async {

    when(
      mockDataLocal.getAll(any),
    ).thenAnswer((_) async => listMapSdkReleases);

      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => 1);

      final result = await repository.addRelease(mockModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.id, mockModelSdkRelease.id);
    });

    test('addReleases should return exception if saveAll fails', () async {
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repository.addRelease(mockModelSdkRelease);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.id, 0);
    });

    test('addListReleases should return SdkReleases id', () async {

      when(
        mockDataLocal.getAll(any),
      ).thenAnswer((_) async => listMapSdkReleases);

      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => 1);

      final result = await repository.addListReleases(mockListModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.count, greaterThan(0));
    });

    test('addListReleases should return exception if saveAll fails', () async {
      when(
        mockDataLocal.getAll(any),
      ).thenAnswer((_) async => listMapSdkReleases);
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repository.addListReleases(mockListModelSdkRelease);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.count, 0);
    });


    test('updateGlobalRelease should return SdkReleases', () async {
      when(
        mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockModelSdkRelease.id);

      final result = await repository.updateGlobalRelease(mockModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.release, mockModelSdkRelease);
    });

    test('updateGlobalRelease should return exception if update fails',
        () async {

      when(
        mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repository.updateGlobalRelease(mockModelSdkRelease);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.release.id, 0);
    });

    test('updateStateReleases should return SdkReleases id', () async {
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => 1);

      const state = SdkState.downloaded;
      expect(mockModelSdkRelease.state, isNot(state));

      final result = await repository.updateReleaseState(
          id: mockModelSdkRelease.id, state: state);
      expect(result.exception, ExptDataNoExpt());
      expect(result.release.state, state);
    });

    test('updateStateReleases should return exception if saveAll fails',
        () async {
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      const state = SdkState.downloaded;
      expect(mockModelSdkRelease.state, isNot(state));

      final result = await repository.updateReleaseState(
          id: mockModelSdkRelease.id, state: state);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.release.id, 0);
    });

    test('updateListStateReleases should return SdkReleases id', () async {
                      when(
        mockDataLocal.getAll(any),
      ).thenAnswer((_) async => listMapSdkReleases);
      
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => 1);

      final result = await repository.updateListReleaseState(
          fromState: SdkState.available, toState: SdkState.installed);
      expect(result.exception, ExptDataNoExpt());
      expect(result.releases.length, greaterThan(0));
    });

    test('updateListStateReleases should return exception if saveAll fails',
        () async {
                when(
        mockDataLocal.getAll(any),
      ).thenAnswer((_) async => listMapSdkReleases);

      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      const state = SdkState.downloaded;
      expect(mockModelSdkRelease.state, isNot(state));

      final result = await repository.updateListReleaseState(
          fromState: SdkState.downloaded, toState: SdkState.available);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.releases.length, 0);
    });
  });

  group('delete records in local repository', () {
    test('delete from RepositoryLocalHome must return number of id deleted',
        () async {
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => 1);

      final result = await repository.deleteRelease(mockModelSdkRelease.id);
      expect(result.exception, ExptDataNoExpt());
      expect(result.id, mockModelSdkRelease.id);
    });

    test(
        'delete from RepositoryLocalHome must return exception if saveAll fails',
        () async {
      when(
        mockDataLocal.saveAll(
            items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repository.deleteRelease(mockModelSdkRelease.id);
      expect(result.exception, isA<ExptDataDelete>());
      expect(result.id, 0);
    });

    test('deleteAll from RepositoryLocalHome must count of records deleted',
        () async {
      when(
        mockDataLocal.deleteAll(any),
      ).thenAnswer((_) async => 1);

      final result = await repository.deleteAllRelease();
      expect(result.exception, ExptDataNoExpt());
      expect(result.count, greaterThan(0));
    });

    test(
        'deleteAll from RepositoryLocalHome must return exception if deleteAll fails',
        () async {
      when(
        mockDataLocal.deleteAll(any),
      ).thenThrow((_) async => throwsException);

      final result = await repository.deleteAllRelease();
      expect(result.exception, isA<ExptDataDelete>());
      expect(result.count, 0);
    });
  });
}
