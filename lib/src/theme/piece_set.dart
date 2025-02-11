import 'package:flutter/material.dart';

// See the example project for a demonstration of how to create a PieceSet with flutter_svg.

/// Used to define the widgets that will be built to represent pieces.
/// Simply provide a map [pieces] of String keys and `WidgetBuilder` values.
/// The keys should be uppercase for white pieces, and lowercase for black,
/// e.g. a white pawn is 'P' and a black pawn is 'p'.
class PieceSet {
  static const List<String> defaultSymbols = ['P', 'N', 'B', 'R', 'Q', 'K'];
  static const List<String> extendedSymbols = [
    //
    'P', 'N', 'B', 'R', 'Q', 'K',
    'A', 'C', 'H', 'E', 'S',
  ];
  static const List<String> xiangqiSymbols = [
    //
    'P', 'N', 'B', 'C',
    'R', 'A', 'K',
  ];

  /// The builders used to create the widgets to represent pieces.
  final Map<String, WidgetBuilder> pieces;
  const PieceSet({required this.pieces});

  /// Build a piece `Widget` for [symbol].
  Widget piece(BuildContext context, String symbol) => pieces[symbol]!(context);

  /// Specifies a set of `WidgetBuilder`s from a set of image files in a folder.
  /// The file names should be in a format like 'wB.png' (white bishop),
  /// 'bN.png' (black knight).
  /// A [format] other than 'png' can be specified, as long as it works with
  /// `Image.asset`. SVG cannot be used with this, but look at `piece_set.dart`
  /// for a commented out example of how flutter_svg can be used.
  /// Make sure that every symbol in [symbols] has a 'wSymbol' and 'bSymbol' file.
  /// If the images are coming from a package (for example, from Squares), then
  /// specify [package].
  /// See `PieceSet.merida()` for an example.
  factory PieceSet.fromImageAssets({
    required String folder,
    String? package,
    required List<String> symbols,
    String format = 'png',
  }) {
    Map<String, WidgetBuilder> pieces = {};
    for (String symbol in symbols) {
      pieces[symbol.toUpperCase()] = (BuildContext context) =>
          Image.asset('${folder}w$symbol.$format', package: package);
      pieces[symbol.toLowerCase()] = (BuildContext context) =>
          Image.asset('${folder}b$symbol.$format', package: package);
    }
    return PieceSet(pieces: pieces);
  }

  /// Specifies a set of `WidgetBuilders` that render `Text` widgets, using
  /// map of piece keys mapped to strings.
  /// Hint: this works with emojis. See the example app.
  factory PieceSet.text({
    required Map<String, String> strings,
    TextStyle? style,
  }) {
    Map<String, WidgetBuilder> pieces = {};
    strings.forEach((k, v) {
      pieces[k] = (BuildContext context) => Text(v, style: style);
    });
    return PieceSet(pieces: pieces);
  }

  /// The classic Merida chess set, including some extra pieces.
  /// Taken from [Pychess](https://github.com/gbtami/pychess-variants/tree/master/static/images/pieces/merida),
  /// thanks CoachTomato! (presumably)
  factory PieceSet.merida() => PieceSet.fromImageAssets(
        folder: 'lib/piece_sets/merida/',
        package: 'squares',
        symbols: extendedSymbols,
      );

  /// The traditional Xiangqi piece set.
  factory PieceSet.xiangqi() => PieceSet.fromImageAssets(
        folder: 'lib/piece_sets/xiangqi/',
        package: 'squares',
        symbols: xiangqiSymbols,
      );

  /// A Xiangqi piece set using chess-like icons.
  factory PieceSet.xiangqiIcons() => PieceSet.fromImageAssets(
        folder: 'lib/piece_sets/xiangqi_icon/',
        package: 'squares',
        symbols: xiangqiSymbols,
      );

  /// Specifies a set of `WidgetBuilders` that render `Text` widgets with only
  /// the piece's symbol inside.
  factory PieceSet.letters({TextStyle? style}) => PieceSet.text(
        strings: {
          //
          'P': 'P', 'p': 'p', 'N': 'N', 'n': 'n',
          'B': 'B', 'b': 'b', 'R': 'R', 'r': 'r',
          'Q': 'Q', 'q': 'q', 'K': 'K', 'k': 'k',
          'C': 'C', 'c': 'c', 'A': 'A', 'a': 'a',
        },
        style: style,
      );
}
