import 'dart:collection';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/mixins/object_mixin.dart';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

mixin HandleGameEvent<T> on Component {
  final _messagesChunk = ListQueue<List<T>>();

  @override
  void update(double dt) {
    super.update(dt);

    if (_messagesChunk.isEmpty) return;
    final message = _messagesChunk.removeFirst();
    _handleEvents(message);
  }

  void addEvents(List<T> messages) {
    _messagesChunk.add(messages);
  }

  void _handleEvents(List<T> messages) {
    throw UnimplementedError();
  }
}

abstract class ObjectFactoryComponent<OT extends DIObject, MT extends BaseEvent>
    extends Component with HasGameRef<DustyIslandGame>, HandleGameEvent<MT> {
  OT facotry(MT message);
  void onGenerateObject(MT message);
  void onRemoveObject(MT message);

  final Map<int, OT> objects = {};

  @override
  void _handleEvents(List<MT> messages) {
    for (var message in messages) {
      switch (message.eventType) {
        case EventType.generate:
          onGenerateObject(message);
          break;
        case EventType.update:
          onUpdateObject(message);
          break;
        case EventType.remove:
          onRemoveObject(message);
          break;
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

  @mustCallSuper
  void onUpdateObject(MT message) {
    final object = objects[message.objectId];
    if (object != null) {
      if (message.states != null) {
        object.updateState(message.states!);
      }
    }
  }
}
