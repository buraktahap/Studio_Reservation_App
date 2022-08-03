import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:studio_reservation_app/deneme/card_item_view.dart';
import 'package:studio_reservation_app/deneme/cards_view_model.dart';

class CardsView extends StatefulWidget {
  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  CardsViewModel _vm = CardsViewModel();

  @override
  void initState() {
    _vm = CardsViewModel();
    _vm.init();
    _vm.fetchCards();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: Observer(builder: (_) {
        if (_vm.cards.isEmpty) {
          return _buildLoading;
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _vm.cards.length + 1,
          itemBuilder: (context, index) {
            if (index == _vm.cards.length) {
              _vm.fetchCards();
              return _buildLoading;
            }

            return CardItemView(card: _vm.cards[index]);
          },
        );
      }),
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
