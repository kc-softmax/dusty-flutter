import 'dart:collection';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';

mixin HandleGameMessage<T> on Component {
  final _messagesChunk = ListQueue<List<T>>();

  @override
  void update(double dt) {
    super.update(dt);

    if (_messagesChunk.isEmpty) return;
    final message = _messagesChunk.removeFirst();
    _handleMessages(message);
  }

  void addMessages(List<T> messages) {
    _messagesChunk.add(messages);
  }

  void _handleMessages(List<T> messages) {
    throw UnimplementedError();
  }
}

abstract class ObjectFactoryComponent<OT extends Component,
        MT extends BaseMessage> extends Component
    with HasGameRef<DustyIslandGame>, HandleGameMessage<MT> {
  OT facotry(MT message);
  void onGenerateObject(MT message);
  void onUpdateObject(MT message);
  void onRemoveObject(MT message);

  final Map<int, OT> objects = {};
  double _lastUpdateTime = 0;
  double? _frameDuration;

  @override
  void update(double dt) {
    if (gameRef.playScene.gameConfig == null) return;
    _frameDuration ??= 1 / gameRef.playScene.gameConfig!.frameRate;

    _lastUpdateTime += dt;
    if (_lastUpdateTime < _frameDuration!) return;

    super.update(dt);

    _lastUpdateTime = 0;
  }

  @override
  void _handleMessages(List<MT> messages) {
    for (var message in messages) {
      switch (message.eventType) {
        case EventType.generate:
          onGenerateObject(message);
        case EventType.update:
          onUpdateObject(message);
        case EventType.remove:
          onRemoveObject(message);
      }
    }
  }

  void clear() {
    for (var element in objects.values) {
      if (element.parent != null) {
        element.removeFromParent();
      }
    }
    objects.clear();
  }
}