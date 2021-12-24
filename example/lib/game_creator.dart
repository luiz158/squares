import 'package:example/game_config.dart';
import 'package:example/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:bishop/bishop.dart' as bishop;

class GameCreator extends StatefulWidget {
  final Function(GameConfig) onCreate;
  const GameCreator({Key? key, required this.onCreate}) : super(key: key);

  @override
  State<GameCreator> createState() => _GameCreatorState();
}

class _GameCreatorState extends State<GameCreator> {
  List<bishop.Variant> variants = [
    bishop.Variant.standard(),
    bishop.Variant.chess960(),
  ];

  List<DropdownMenuItem<int>> get _variantDropdownItems {
    List<DropdownMenuItem<int>> items = [];
    variants.asMap().forEach((k, v) => items.add(DropdownMenuItem(value: k, child: Text(v.name))));
    return items;
  }

  int variant = 0;

  void _setVariant(int? v) => setState(() => variant = v ?? variant);

  void _createGame() {
    final config = GameConfig(variant: variants[variant]);
    widget.onCreate(config);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Game Setup',
          style: Theme.of(context).textTheme.headline5,
        ),
        Divider(),
        DropdownButton<int>(
          value: variant,
          items: _variantDropdownItems,
          onChanged: _setVariant,
        ),
        ElevatedButton(
          onPressed: _createGame,
          child: Text('Create Game'),
        ),
      ],
    );
  }
}
