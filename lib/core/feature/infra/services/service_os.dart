import 'package:fegi/core/exceptions/expt_service.dart';

abstract class ServiceOs {
  ExptService createEnvPath({required String path, required String key, required String value});
  ExptService updateEnvPath({required String path, required String key, required String value});
  ExptService removeEnvPath({required String path, required String key});
  ({List<String> list, ExptService exptService}) readEnvPath({required String path, required String key});
}
