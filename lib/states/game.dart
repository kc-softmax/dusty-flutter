import 'package:flutter/widgets.dart';

class GameModel with ChangeNotifier {
  bool _isReset = false;

  get isReset => _isReset;

  void restGame() {
    _isReset = true;
    notifyListeners();
  }

  void startGame() {
    _isReset = false;
    notifyListeners();
  }
}
