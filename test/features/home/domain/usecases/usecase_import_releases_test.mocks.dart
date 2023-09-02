// Mocks generated by Mockito 5.4.2 from annotations
// in fegi/test/features/home/domain/usecases/usecase_import_releases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:fegi/core/exceptions/expt_data.dart' as _i2;
import 'package:fegi/core/feature/domain/entities/sdk_release.dart' as _i3;
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart'
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

class _FakeExptData_0 extends _i1.SmartFake implements _i2.ExptData {
  _FakeExptData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSdkRelease_1 extends _i1.SmartFake implements _i3.SdkRelease {
  _FakeSdkRelease_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RepositoryLocalHome].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepositoryLocalHome extends _i1.Mock
    implements _i4.RepositoryLocalRelease {
  @override
  _i5.Future<({_i2.ExptData exception, int id})> addRelease(
          _i3.SdkRelease? release) =>
      (super.noSuchMethod(
        Invocation.method(
          #addRelease,
          [release],
        ),
        returnValue: _i5.Future<({_i2.ExptData exception, int id})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #addRelease,
              [release],
            ),
          ),
          id: 0
        )),
        returnValueForMissingStub:
            _i5.Future<({_i2.ExptData exception, int id})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #addRelease,
              [release],
            ),
          ),
          id: 0
        )),
      ) as _i5.Future<({_i2.ExptData exception, int id})>);
  @override
  _i5.Future<({int count, _i2.ExptData exception})> addListReleases(
          List<_i3.SdkRelease>? releases) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListReleases,
          [releases],
        ),
        returnValue: _i5.Future<({int count, _i2.ExptData exception})>.value((
          count: 0,
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #addListReleases,
              [releases],
            ),
          )
        )),
        returnValueForMissingStub:
            _i5.Future<({int count, _i2.ExptData exception})>.value((
          count: 0,
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #addListReleases,
              [releases],
            ),
          )
        )),
      ) as _i5.Future<({int count, _i2.ExptData exception})>);
  @override
  _i5.Future<
      ({_i2.ExptData exception, _i3.SdkRelease release})> updateReleaseState({
    required int? id,
    required int? state,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateReleaseState,
          [],
          {
            #id: id,
            #state: state,
          },
        ),
        returnValue: _i5
            .Future<({_i2.ExptData exception, _i3.SdkRelease release})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #updateReleaseState,
              [],
              {
                #id: id,
                #state: state,
              },
            ),
          ),
          release: _FakeSdkRelease_1(
            this,
            Invocation.method(
              #updateReleaseState,
              [],
              {
                #id: id,
                #state: state,
              },
            ),
          )
        )),
        returnValueForMissingStub: _i5
            .Future<({_i2.ExptData exception, _i3.SdkRelease release})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #updateReleaseState,
              [],
              {
                #id: id,
                #state: state,
              },
            ),
          ),
          release: _FakeSdkRelease_1(
            this,
            Invocation.method(
              #updateReleaseState,
              [],
              {
                #id: id,
                #state: state,
              },
            ),
          )
        )),
      ) as _i5.Future<({_i2.ExptData exception, _i3.SdkRelease release})>);
  @override
  _i5.Future<({_i2.ExptData exception, List<_i3.SdkRelease> releases})>
      updateListReleaseState({
    required int? fromState,
    required int? toState,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #updateListReleaseState,
              [],
              {
                #fromState: fromState,
                #toState: toState,
              },
            ),
            returnValue: _i5.Future<
                ({
                  _i2.ExptData exception,
                  List<_i3.SdkRelease> releases
                })>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #updateListReleaseState,
                  [],
                  {
                    #fromState: fromState,
                    #toState: toState,
                  },
                ),
              ),
              releases: <_i3.SdkRelease>[]
            )),
            returnValueForMissingStub: _i5.Future<
                ({
                  _i2.ExptData exception,
                  List<_i3.SdkRelease> releases
                })>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #updateListReleaseState,
                  [],
                  {
                    #fromState: fromState,
                    #toState: toState,
                  },
                ),
              ),
              releases: <_i3.SdkRelease>[]
            )),
          ) as _i5.Future<
              ({_i2.ExptData exception, List<_i3.SdkRelease> releases})>);
  @override
  _i5.Future<({_i2.ExptData exception, int id})> deleteRelease(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteRelease,
          [id],
        ),
        returnValue: _i5.Future<({_i2.ExptData exception, int id})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #deleteRelease,
              [id],
            ),
          ),
          id: 0
        )),
        returnValueForMissingStub:
            _i5.Future<({_i2.ExptData exception, int id})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #deleteRelease,
              [id],
            ),
          ),
          id: 0
        )),
      ) as _i5.Future<({_i2.ExptData exception, int id})>);
  @override
  _i5.Future<({int count, _i2.ExptData exception})> deleteAllRelease() =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAllRelease,
          [],
        ),
        returnValue: _i5.Future<({int count, _i2.ExptData exception})>.value((
          count: 0,
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #deleteAllRelease,
              [],
            ),
          )
        )),
        returnValueForMissingStub:
            _i5.Future<({int count, _i2.ExptData exception})>.value((
          count: 0,
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #deleteAllRelease,
              [],
            ),
          )
        )),
      ) as _i5.Future<({int count, _i2.ExptData exception})>);
  @override
  _i5.Future<({_i2.ExptData exception, List<_i3.SdkRelease> releases})>
      loadListRelease() => (super.noSuchMethod(
            Invocation.method(
              #loadListRelease,
              [],
            ),
            returnValue: _i5.Future<
                ({
                  _i2.ExptData exception,
                  List<_i3.SdkRelease> releases
                })>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #loadListRelease,
                  [],
                ),
              ),
              releases: <_i3.SdkRelease>[]
            )),
            returnValueForMissingStub: _i5.Future<
                ({
                  _i2.ExptData exception,
                  List<_i3.SdkRelease> releases
                })>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #loadListRelease,
                  [],
                ),
              ),
              releases: <_i3.SdkRelease>[]
            )),
          ) as _i5.Future<
              ({_i2.ExptData exception, List<_i3.SdkRelease> releases})>);
  @override
  _i5.Future<({_i2.ExptData exception, _i3.SdkRelease release})>
      loadGlobalRelease() => (super.noSuchMethod(
            Invocation.method(
              #loadGlobalRelease,
              [],
            ),
            returnValue: _i5.Future<
                ({_i2.ExptData exception, _i3.SdkRelease release})>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #loadGlobalRelease,
                  [],
                ),
              ),
              release: _FakeSdkRelease_1(
                this,
                Invocation.method(
                  #loadGlobalRelease,
                  [],
                ),
              )
            )),
            returnValueForMissingStub: _i5.Future<
                ({_i2.ExptData exception, _i3.SdkRelease release})>.value((
              exception: _FakeExptData_0(
                this,
                Invocation.method(
                  #loadGlobalRelease,
                  [],
                ),
              ),
              release: _FakeSdkRelease_1(
                this,
                Invocation.method(
                  #loadGlobalRelease,
                  [],
                ),
              )
            )),
          ) as _i5.Future<({_i2.ExptData exception, _i3.SdkRelease release})>);
  @override
  _i5.Future<
      ({_i2.ExptData exception, _i3.SdkRelease release})> updateGlobalRelease(
          _i3.SdkRelease? sdkVersion) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateGlobalRelease,
          [sdkVersion],
        ),
        returnValue: _i5
            .Future<({_i2.ExptData exception, _i3.SdkRelease release})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #updateGlobalRelease,
              [sdkVersion],
            ),
          ),
          release: _FakeSdkRelease_1(
            this,
            Invocation.method(
              #updateGlobalRelease,
              [sdkVersion],
            ),
          )
        )),
        returnValueForMissingStub: _i5
            .Future<({_i2.ExptData exception, _i3.SdkRelease release})>.value((
          exception: _FakeExptData_0(
            this,
            Invocation.method(
              #updateGlobalRelease,
              [sdkVersion],
            ),
          ),
          release: _FakeSdkRelease_1(
            this,
            Invocation.method(
              #updateGlobalRelease,
              [sdkVersion],
            ),
          )
        )),
      ) as _i5.Future<({_i2.ExptData exception, _i3.SdkRelease release})>);
}
