import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_settings.dart';
import 'package:fegi/features/settings/domain/usecases/usecase_change_settings.dart';
import 'package:fegi/features/home/infra/repositories/repository_local_settings_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../infra/models/mock_settings_model.dart';

@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'usecase_change_settings_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalSettings repositoryLocal;
  late UsecaseChangeSettings usecaseChangeSettings;

  setUp(() {
    repositoryLocal = RepositoryLocalSettingsImpl(mockDataLocal);
    usecaseChangeSettings = UsecaseChangeSettings(repositoryLocal);
  });
  test('save all Settings with NoExceptionDB', () async {

    when(
      mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
    ).thenAnswer((_) async => mockSettingsModel.id);

    final result = await usecaseChangeSettings.call(mockSettingsModel);

    expect(result.id, mockSettingsModel.id);
    expect(result.exception, ExptDataNoExpt());
  });
  test('save all Settings with Exception', () async {

    when(
      mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
    ).thenThrow((_) async => throwsException);

    final result = await usecaseChangeSettings.call(mockSettingsModel);

    expect(result.id, 0);
    expect(result.exception, isA<ExptDataSave>());
  });
}
