import 'dart:collection';
import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';

mixin HandleGameMessage<T> on Component {
  final ListQueue<T> _messages = ListQueue<T>();

  @override
  void update(double dt) {
    super.update(dt);

    if (_messages.isEmpty) return;
    final message = _messages.removeFirst();
    _handleMessage(message);
  }

  void addMessage(List<T> message) {
    _messages.addAll(message);
  }

  void _handleMessage(T message) {
    throw UnimplementedError();
  }
}

abstract class ObjectFactoryComponent<OT, MT extends BaseMessage>
    extends Component with HandleGameMessage<MT> {
  final List<OT> objects = [];

  @override
  void _handleMessage(MT message) {
    switch (message.eventType) {
      case EventType.generate:
        onGenerateObject(message);
      case EventType.update:
        onUpdateObject(message);
      case EventType.remove:
        onRemoveObject(message);
    }
  }

  void onGenerateObject(MT message);
  void onUpdateObject(MT message);
  void onRemoveObject(MT message);
}

class ExampleDustyFactory extends ObjectFactoryComponent<Dusty, DustyMessage>
    with HasGameRef<DustyIslandGame> {
  @override
  void onGenerateObject(DustyMessage message) {
    final player = Dusty()
      ..x = Random().nextInt(400) + 300
      ..y = Random().nextInt(400) + 300;
    gameRef.world.add(player);
  }

  @override
  void onRemoveObject(DustyMessage message) {}

  @override
  void onUpdateObject(DustyMessage message) {}
}
