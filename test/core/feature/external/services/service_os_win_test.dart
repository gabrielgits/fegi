import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/external/services/service_os_win.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ServiceOsWin serviceOs = ServiceOsWin();

  group('ServiceOsWin Test', () {
    String value = '3.0.0';
    String path = r'Software\fegi\test';
    String key = 'globalSdkTest';
    test('create Env Path', () {
      final result = serviceOs.createEnvPath(path:path, key: key, value: value);
      expect(result, ExptServiceNoExpt());
    });

    test('read Env Path', () {
      final result = serviceOs.readEnvPath(path: path, key: key);
      expect(result.list.first, value);
      expect(result.exptService, ExptServiceNoExpt());
    });

    test('update Env Path', () {
      final result = serviceOs.updateEnvPath(path: path, key: key, value: value);
      expect(result, ExptServiceNoExpt());
    });

    test('delete Env Path', () {
      final result = serviceOs.removeEnvPath(path: path, key: key);
      expect(result, ExptServiceNoExpt());
    });

  });
}
