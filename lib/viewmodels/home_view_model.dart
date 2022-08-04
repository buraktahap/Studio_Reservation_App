import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/core/base/model/base_viewmodel.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
    void init() {
      // TODO: implement init
    }
}
