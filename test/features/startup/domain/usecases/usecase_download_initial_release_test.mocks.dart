// Mocks generated by Mockito 5.4.2 from annotations
// in fegi/test/features/startup/domain/usecases/usecase_download_initial_release_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:fegi/core/exceptions/expt_service.dart' as _i3;
import 'package:fegi/core/exceptions/expt_web.dart' as _i2;
import 'package:fegi/core/feature/infra/services/service_file.dart' as _i6;
import 'package:fegi/features/startup/domain/repositories/repository_remote_startup.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeExptWeb_0 extends _i1.SmartFake implements _i2.ExptWeb {
  _FakeExptWeb_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExptService_1 extends _i1.SmartFake implements _i3.ExptService {
  _FakeExptService_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RepositoryRemoteStartup].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepositoryRemoteStartup extends _i1.Mock
    implements _i4.RepositoryRemoteStartup {
  @override
  _i5.Future<({List<int> data, _i2.ExptWeb exception})> downloadFile(
          String? link) =>
      (super.noSuchMethod(
        Invocation.method(
          #downloadFile,
          [link],
        ),
        returnValue:
            _i5.Future<({List<int> data, _i2.ExptWeb exception})>.value((
          data: <int>[],
          exception: _FakeExptWeb_0(
            this,
            Invocation.method(
              #downloadFile,
              [link],
            ),
          )
        )),
        returnValueForMissingStub:
            _i5.Future<({List<int> data, _i2.ExptWeb exception})>.value((
          data: <int>[],
          exception: _FakeExptWeb_0(
            this,
            Invocation.method(
              #downloadFile,
              [link],
            ),
          )
        )),
      ) as _i5.Future<({List<int> data, _i2.ExptWeb exception})>);
}

/// A class which mocks [ServiceFile].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceFile extends _i1.Mock implements _i6.ServiceFile {
  @override
  _i3.ExptService deleteFile(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteFile,
          [path],
        ),
        returnValue: _FakeExptService_1(
          this,
          Invocation.method(
            #deleteFile,
            [path],
          ),
        ),
        returnValueForMissingStub: _FakeExptService_1(
          this,
          Invocation.method(
            #deleteFile,
            [path],
          ),
        ),
      ) as _i3.ExptService);
  @override
  _i3.ExptService saveFile({
    required String? savePath,
    required List<int>? fileData,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFile,
          [],
          {
            #savePath: savePath,
            #fileData: fileData,
          },
        ),
        returnValue: _FakeExptService_1(
          this,
          Invocation.method(
            #saveFile,
            [],
            {
              #savePath: savePath,
              #fileData: fileData,
            },
          ),
        ),
        returnValueForMissingStub: _FakeExptService_1(
          this,
          Invocation.method(
            #saveFile,
            [],
            {
              #savePath: savePath,
              #fileData: fileData,
            },
          ),
        ),
      ) as _i3.ExptService);
  @override
  _i3.ExptService deleteFolder(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteFolder,
          [path],
        ),
        returnValue: _FakeExptService_1(
          this,
          Invocation.method(
            #deleteFolder,
            [path],
          ),
        ),
        returnValueForMissingStub: _FakeExptService_1(
          this,
          Invocation.method(
            #deleteFolder,
            [path],
          ),
        ),
      ) as _i3.ExptService);
  @override
  ({_i3.ExptService exptService, String path}) getAppPath() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAppPath,
          [],
        ),
        returnValue: (
          exptService: _FakeExptService_1(
            this,
            Invocation.method(
              #getAppPath,
              [],
            ),
          ),
          path: ''
        ),
        returnValueForMissingStub: (
          exptService: _FakeExptService_1(
            this,
            Invocation.method(
              #getAppPath,
              [],
            ),
          ),
          path: ''
        ),
      ) as ({_i3.ExptService exptService, String path}));
  @override
  _i5.Future<_i3.ExptService> openUrl(String? link) => (super.noSuchMethod(
        Invocation.method(
          #openUrl,
          [link],
        ),
        returnValue: _i5.Future<_i3.ExptService>.value(_FakeExptService_1(
          this,
          Invocation.method(
            #openUrl,
            [link],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.ExptService>.value(_FakeExptService_1(
          this,
          Invocation.method(
            #openUrl,
            [link],
          ),
        )),
      ) as _i5.Future<_i3.ExptService>);
}
