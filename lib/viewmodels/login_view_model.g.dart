// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  late final _$citiesAtom =
      Atom(name: '_LoginViewModelBase.cities');

  @override
  List<dynamic> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<dynamic> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  @override
  ObservableFuture<String?> signIn(String email, String password) {
    final _$future = super.signIn(email, password);
    return ObservableFuture<String?>(_$future);
  }

  late final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase');

  @override
  dynamic getCities() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.getCities');
    try {
      return super.getCities();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cities: ${cities}
    ''';
  }
}
