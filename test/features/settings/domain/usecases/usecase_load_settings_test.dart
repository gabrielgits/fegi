import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_settings.dart';
import 'package:fegi/features/settings/domain/usecases/usecase_load_settings.dart';
import 'package:fegi/features/home/infra/repositories/repository_local_settings_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../infra/models/mock_settings_model.dart';
@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'usecase_load_settings_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalSettings repositoryLocal;
  late UsecaseLoadSettings usecaseLoadSettings;

  setUp(() {
    repositoryLocal = RepositoryLocalSettingsImpl(mockDataLocal);
    usecaseLoadSettings = UsecaseLoadSettings(repositoryLocal);
  });
  test('load Settings without no exception DB', () async {

    when(
      mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
    ).thenAnswer((_) async => mockSettingsModel.toMap());

    final result = await usecaseLoadSettings.call();

    expect(result.settings, mockSettingsModel);
    expect(result.exception, ExptDataNoExpt());
  });
  test('load Settings with exception', () async {

    when(
      mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
    ).thenThrow((_) async => throwsException);

    final result = await usecaseLoadSettings.call();

    expect(result.settings.id, 0);
    expect(result.exception, isA<ExptDataLoad>());
  });
}
