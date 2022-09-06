// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingViewModel on _BookingViewModelBase, Store {
  late final _$enrollStatusAtom =
      Atom(name: '_BookingViewModelBase.enrollStatus');

  @override
  String get enrollStatus {
    _$enrollStatusAtom.reportRead();
    return super.enrollStatus;
  }

  @override
  set enrollStatus(String value) {
    _$enrollStatusAtom.reportWrite(value, super.enrollStatus, () {
      super.enrollStatus = value;
    });
  }

  late final _$lessonsAtom = Atom(name: '_BookingViewModelBase.lessons');

  @override
  List<dynamic> get lessons {
    _$lessonsAtom.reportRead();
    return super.lessons;
  }

  @override
  set lessons(List<dynamic> value) {
    _$lessonsAtom.reportWrite(value, super.lessons, () {
      super.lessons = value;
    });
  }

  @override
  ObservableFuture<List<GetLessonsByBranchNameWithEnroll>?> lessonsByBranchName(
      String? Location) {
    final _$future = super.lessonsByBranchName(Location);
    return ObservableFuture<List<GetLessonsByBranchNameWithEnroll>?>(_$future);
  }

  @override
  ObservableFuture<dynamic> enroll(int lessonId) {
    final _$future = super.enroll(lessonId);
    return ObservableFuture<dynamic>(_$future);
  }

  @override
  String toString() {
    return '''
enrollStatus: ${enrollStatus},
lessons: ${lessons}
    ''';
  }
}
