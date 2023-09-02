import 'package:fegi/features/home/domain/usecases/usecase_load_global_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_remove_release.dart';
import 'package:provider/provider.dart';

import '../features/home/domain/repositories/repository_local_release.dart';
import '../features/home/domain/repositories/repository_remote_release.dart';
import '../features/home/domain/usecases/usecase_change_settings.dart';
import '../features/home/domain/usecases/usecase_delete_all_releases.dart';
import '../features/home/domain/usecases/usecase_delete_release.dart';
import '../features/home/domain/usecases/usecase_download_all_releases.dart';
import '../features/home/domain/usecases/usecase_download_release.dart';
import '../features/home/domain/usecases/usecase_get_list_releases.dart';
import '../features/home/domain/usecases/usecase_global_remove_release.dart';
import '../features/home/domain/usecases/usecase_import_releases.dart';
import '../features/home/domain/usecases/usecase_install_release.dart';
import '../features/home/domain/usecases/usecase_load_releases.dart';
import '../features/home/domain/usecases/usecase_global_set_release.dart';
import '../features/home/domain/usecases/usecase_load_settings.dart';
import '../features/home/domain/usecases/usecase_setdefault_settings.dart';
import '../features/home/domain/usecases/usecase_uninstall_release.dart';
import '../features/home/infra/repositories/repository_local_release_impl.dart';
import '../features/home/infra/repositories/repository_local_settings_impl.dart';
import '../features/home/infra/repositories/repository_remote_release_impl.dart';
import '../features/home/presenter/controllers/controller_home.dart';
import '../features/home/domain/repositories/repository_local_settings.dart';
import '../features/startup/domain/repositories/repository_local_startup.dart';
import '../features/startup/domain/repositories/repository_remote_startup.dart';
import '../features/startup/domain/usecases/usecase_create_initial_settings.dart';
import '../features/startup/domain/usecases/usecase_download_initial_release.dart';
import '../features/startup/domain/usecases/usecase_install_initial_release.dart';
import '../features/startup/domain/usecases/usecase_setglobal_initial_release.dart';
import '../features/startup/infra/repositories/repository_local_startup_impl.dart';
import '../features/startup/infra/repositories/repository_remote_startup_impl.dart';
import '../features/startup/presenter/controllers/controller_startup.dart';
import 'feature/external/datasources/data_http_dio.dart';
import 'feature/external/datasources/data_local_shared_pref.dart';
import 'feature/external/services/service_compress_archive_io.dart';
import 'feature/external/services/service_file.dart';
import 'feature/external/services/service_os_win.dart';
import 'feature/infra/datasources/data_http.dart';
import 'feature/infra/datasources/data_local.dart';
import 'feature/infra/services/service_compress.dart';
import 'feature/infra/services/service_file.dart';
import 'feature/infra/services/service_os.dart';

final providersApp = [
  ///  core providers
  Provider<DataHttp>(create: (context) => DataHttpDio()),
  Provider<DataLocal>(create: (_) => DataLocalSharedPref()),
  Provider<ServiceOs>(create: (_) => ServiceOsWin()),
  Provider<ServiceFile>(create: (_) => ServiceFileImpl()),
  Provider<ServiceCompress>(create: (_) => ServiceCompressArchiveIo()),

  /// features providers

  /// * startup providers
  /// ** repository
  Provider<RepositoryLocalStartup>(
    create: (context) => RepositoryLocalStartupImpl(context.read()),
  ),
  Provider<RepositoryRemoteStartup>(
    create: (context) => RepositoryRemoteStartupImpl(context.read()),
  ),

  /// ** usecase
  Provider(
    create: (context) => UsecaseCreateInitialSettings(
      repositoryLocal: context.read(),
      serviceOs: context.read(),
    ),
  ),
  Provider(
    create: ((context) => UsecaseDownloadInitialReleases(
          repositoryRemote: context.read(),
          serviceFile: context.read(),
        )),
  ),
  Provider(
    create: ((context) => UsecaseInstallInitialRelease(
          repositoryLocal: context.read(),
          serviceCompress: context.read(),
        )),
  ),
  Provider(
    create: ((context) => UsecaseSetglobalInitialRelease(
          serviceFile: context.read(),
          serviceOs: context.read(),
          repositoryLocal: context.read(),
        )),
  ),

  /// ** controller
  ChangeNotifierProvider(
    create: (context) => ControllerStartup(
      usecaseCreateInitialSettings: context.read(),
      usecaseDownloadInitialReleases: context.read(),
      usecaseInstallInitialRelease: context.read(),
      usecaseSetglobalInitialRelease: context.read(),
    ),
  ),

  /// * settings providers
  /// ** repository
  Provider<RepositoryLocalSettings>(
    create: (context) => RepositoryLocalSettingsImpl(
      context.read(),
    ),
  ),

  /// ** usecase
  Provider(create: (context) => UsecaseChangeSettings(context.read())),
  Provider(create: (context) => UsecaseLoadSettings(context.read())),
  Provider(create: (context) => UsecaseSetdefaultSettings(context.read())),


  /// * home providers
  /// ** repository
  Provider<RepositoryLocalRelease>(
      create: (context) => RepositoryLocalReleaseImpl(context.read())),
  Provider<RepositoryRemoteRelease>(
      create: (context) => RepositoryRemoteReleaseImpl(context.read())),

  /// ** usecase
  Provider(
    create: (context) => UseCaseDeleteAllReleases(
      repositoryLocal: context.read(),
      serviceFile: context.read(),
    ),
  ),
  Provider(
    create: (context) => UsecaseDeleteRelease(
      repositoryLocal: context.read(),
      serviceFile: context.read(),
    ),
  ),
  Provider(
    create: (context) => UseCaseDownloadAllReleases(
      repositoryLocal: context.read(),
      repositoryRemote: context.read(),
      serviceFile: context.read(),
    ),
  ),
  Provider(
    create: (context) => UsecaseDownloadReleases(
      repositoryLocal: context.read(),
      repositoryRemote: context.read(),
      serviceFile: context.read(),
    ),
  ),
  Provider(create: (context) => UsecaseGetListReleases(context.read())),
  Provider(create: (context) => UsecaseImportReleases(context.read())),
  Provider(
    create: (context) => UsecaseInstallRelease(
      repositoryLocal: context.read(),
      serviceCompress: context.read(),
    ),
  ),
  Provider(create: (context) => UsecaseLoadReleases(context.read())),
  Provider(create: (context) => UsecaseLoadGlobalRelease(context.read())),
  Provider(
    create: (context) => UsecaseGlobalSetRelease(
      serviceOs: context.read(),
      serviceFile: context.read(),
      repositoryLocal: context.read(),
    ),
  ),
  Provider(
    create: (context) => UsecaseGlobalRemoveRelease(
      serviceOs: context.read(),
      serviceFile: context.read(),
      repositoryLocal: context.read(),
    ),
  ),
  Provider(
    create: (context) => UsecaseUninstallRelease(
      repositoryLocal: context.read(),
      serviceFile: context.read(),
    ),
  ),
  Provider(create: (context) => UsecaseRemoveRelease(context.read())),

  /// ** controller
  ChangeNotifierProvider(
    create: (context) => ControllerHome(
      usecaseDeleteAllRelease: context.read(),
      usecaseDeleteRelease: context.read(),
      usecaseDownloadAllRelease: context.read(),
      usecaseDownloadRelease: context.read(),
      usecaseGetListReleases: context.read(),
      usecaseImportReleases: context.read(),
      usecaseInstallRelease: context.read(),
      usecaseLoadReleases: context.read(),
      usecaseLoadGlobalRelease: context.read(),
      usecaseSetglobalRelease: context.read(),
      usecaseGlobalRemoveRelease: context.read(),
      usecaseRemoveRelease: context.read(),
      usecaseUninstallRelease: context.read(),
      usecaseLoadSettings: context.read(),
      usecaseChangeSettings: context.read(),
      usecaseDefaultSettings: context.read(),
    ),
  )
];
