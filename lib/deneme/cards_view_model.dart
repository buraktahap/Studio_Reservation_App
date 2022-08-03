import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/classes/lesson.dart';
import 'package:studio_reservation_app/classes/pagination_mode.dart';
import 'package:studio_reservation_app/deneme/card_service_interface.dart';

import 'card_service.dart';

part 'cards_view_model.g.dart';

class CardsViewModel = _CardsViewModel with _$CardsViewModel;

abstract class _CardsViewModel with Store {
  late CardServiceInterface _service;

  bool isFetchData = false;
  int _page = 1;
  int _limit = 5;

  void init() {
    _service = CardService();
  }

  ObservableList<Lesson> cards = ObservableList<Lesson>();

  Future fetchCards() async {
    if (isFetchData) {
      return;
    }

    isFetchData = true;

    print(_page);

    var paginate = PaginationModel(page: _page, limit: _limit);
    var res = await _service.fetchCards(paginate);
    if (res != null && res.isNotEmpty) {
      cards.addAll(res);
      _page++;
    }

    isFetchData = false;
  }
}