// Mocks generated by Mockito 5.4.2 from annotations
// in fegi/test/features/home/domain/usecases/usecase_get_list_releases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:expt/expt.dart' as _i2;
import 'package:fegi/core/feature/domain/entities/sdk_release.dart' as _i5;
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart'
    as _i3;
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

/// A class which mocks [RepositoryRemoteRelease].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepositoryRemoteRelease extends _i1.Mock
    implements _i3.RepositoryRemoteRelease {
  @override
  _i4.Future<({_i2.ExptWeb exception, List<_i5.SdkRelease> releases})>
      getListReleases(String? url) => (super.noSuchMethod(
            Invocation.method(
              #getListReleases,
              [url],
            ),
            returnValue: _i4.Future<
                ({
                  _i2.ExptWeb exception,
                  List<_i5.SdkRelease> releases
                })>.value((
              exception: _FakeExptWeb_0(
                this,
                Invocation.method(
                  #getListReleases,
                  [url],
                ),
              ),
              releases: <_i5.SdkRelease>[]
            )),
            returnValueForMissingStub: _i4.Future<
                ({
                  _i2.ExptWeb exception,
                  List<_i5.SdkRelease> releases
                })>.value((
              exception: _FakeExptWeb_0(
                this,
                Invocation.method(
                  #getListReleases,
                  [url],
                ),
              ),
              releases: <_i5.SdkRelease>[]
            )),
          ) as _i4.Future<
              ({_i2.ExptWeb exception, List<_i5.SdkRelease> releases})>);
  @override
  _i4.Future<({List<int> data, _i2.ExptWeb exception})> downloadFile(
          String? link) =>
      (super.noSuchMethod(
        Invocation.method(
          #downloadFile,
          [link],
        ),
        returnValue:
            _i4.Future<({List<int> data, _i2.ExptWeb exception})>.value((
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
            _i4.Future<({List<int> data, _i2.ExptWeb exception})>.value((
          data: <int>[],
          exception: _FakeExptWeb_0(
            this,
            Invocation.method(
              #downloadFile,
              [link],
            ),
          )
        )),
      ) as _i4.Future<({List<int> data, _i2.ExptWeb exception})>);
}
