
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/infra/datasources/data_http.dart';

import '../../domain/repositories/repository_remote_startup.dart';

class RepositoryRemoteStartupImpl implements RepositoryRemoteStartup {
  final DataHttp datasource;
  const RepositoryRemoteStartupImpl(this.datasource);

  @override
  Future<({List<int> data, ExptWeb exception})> downloadFile(String link) async {
    try {
      final data = await datasource.getData(link);
      return (data: data, exception: ExptWebNoExpt());
    } catch (e) {
      List<int> data = [];
      return (data: data, exception: ExptWebGet(e.toString()));
    }
  }
  
}
