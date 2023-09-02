class App {
  //app
  static const debug = true;
  static const name = 'fegi';
  static const version = '0.1';
  static const versionCode = 1;
  static const describe = 'Flutter Easy GUI Install ver. 0.1';
  static const copyrith = 'Copyright © 2023 GV.';
  static const dev = 'GV';

  //url
  static const url =
      'https://raw.githubusercontent.com/gabrielgits/fegi/release';
  static const urlUpgrader = '$url/upgrader/$name.xml';
  static const urlGoogle =
      'https://storage.googleapis.com/flutter_infra_release/releases/';
  static const urlGoogleWinApi = '${urlGoogle}releases_windows.json';

  // path
  static const path = 'bin/';
  static const pathSdk = '${path}sdk/';
  static const pathSdkFiles = '${path}sdkfiles/';
  static const pathProjects = '/projets/';

  // key
  static const keyWinPathApp = r'Software\fegi';
  static const keyGlobalSdk = 'GlobalSdk';
  static const keyWinPathEnv = 'Environment';
  static const keyPath = 'Path';
}
