// ignore_for_file: avoid_print

import 'package:expt/expt.dart';
import 'package:win32_registry/win32_registry.dart';
import '../../infra/services/service_os.dart';

class ServiceOsWin implements ServiceOs {
  @override
  ExptService removeEnvPath({
    required String path,
    required String key,
  }) {
    try {
      final registryKey = Registry.openPath(
        RegistryHive.currentUser,
        path: path,
        desiredAccessRights: AccessRights.writeOnly,
      );
      registryKey.deleteValue(key);
      registryKey.close();
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute('Key not deleted: ${e.toString()}');
    }
  }

  @override
  ExptService createEnvPath({
    required String path,
    required String key,
    required String value,
  }) {
    try {
      final registryKeyEnv = Registry.currentUser;
      final registryKeyPath = registryKeyEnv.createKey(path);

      final registryValue = RegistryValue(key, RegistryValueType.string, value);
      registryKeyPath
        ..createValue(registryValue)
        ..close();
      registryKeyEnv.close();
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute('Key not created: ${e.toString()}');
    }
  }

  @override
  ({List<String> list, ExptService exptService}) readEnvPath({
    required String path,
    required String key,
  }) {
    try {
      final registryKey =
          Registry.openPath(RegistryHive.currentUser, path: path);
      final value = registryKey.getValueAsString(key);
      
      List<String> values = value!.split(';');
      registryKey.close();
      return (list: values, exptService: ExptServiceNoExpt());
    } catch (e) {
      return (
        list: [],
        exptService: ExptServiceExecute('Key not created: ${e.toString()}')
      );
    }
  }

  @override
  ExptService updateEnvPath({
    required String path,
    required String key,
    required String value,
  }) {
    try {
      final registryKeyEnv = Registry.currentUser;
      final registryKeyPath = registryKeyEnv.createKey(path);

      final registryValue = RegistryValue(key, RegistryValueType.string, value);
      registryKeyPath
        ..createValue(registryValue)
        ..close();
      registryKeyEnv.close();
      return ExptServiceNoExpt();
    } catch (e) {
      return ExptServiceExecute('Key not updated: ${e.toString()}');
    }
  }
}
