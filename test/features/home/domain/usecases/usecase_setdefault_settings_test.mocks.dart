// Mocks generated by Mockito 5.4.2 from annotations
// in fegi/test/features/home/domain/usecases/usecase_setdefault_settings_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:feds/src/infra/feds_local.dart' as _i2;
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

/// A class which mocks [FedsLocal].
///
/// See the documentation for Mockito's code generation for more information.
class MockFedsLocal extends _i1.Mock implements _i2.FedsLocal {
  @override
  _i3.Future<int> save({
    required Map<String, dynamic>? item,
    required String? table,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [],
          {
            #item: item,
            #table: table,
          },
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> saveAll({
    required List<Map<String, dynamic>>? items,
    required String? table,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveAll,
          [],
          {
            #items: items,
            #table: table,
          },
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<List<Map<String, dynamic>>> getAll(String? table) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [table],
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
        returnValueForMissingStub: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<Map<String, dynamic>> getItem({
    required int? id,
    required String? table,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getItem,
          [],
          {
            #id: id,
            #table: table,
          },
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
        returnValueForMissingStub:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<Map<String, dynamic>>> searchAll({
    required String? table,
    required String? criteria,
    List<Object?>? criteriaListData,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchAll,
          [],
          {
            #table: table,
            #criteria: criteria,
            #criteriaListData: criteriaListData,
          },
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
        returnValueForMissingStub: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<Map<String, dynamic>> search({
    required String? table,
    required String? criteria,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [],
          {
            #table: table,
            #criteria: criteria,
          },
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
        returnValueForMissingStub:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<int> searchUpdate({
    required String? table,
    required String? criteria,
    required Map<String, dynamic>? item,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchUpdate,
          [],
          {
            #table: table,
            #criteria: criteria,
            #item: item,
          },
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> searchDelete(
    String? table,
    String? criteria,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchDelete,
          [
            table,
            criteria,
          ],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> update({
    required Map<String, dynamic>? item,
    required String? table,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [],
          {
            #item: item,
            #table: table,
          },
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> delete({
    required int? id,
    required String? table,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #id: id,
            #table: table,
          },
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> deleteAll(String? table) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [table],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}
