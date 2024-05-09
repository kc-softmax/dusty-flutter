import 'dart:collection';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
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
    } else {
      // TODO
      // state update 메시지가 왔는데
      // 생성된 object가 없다.
    }
  }
}

abstract class BaseObjectsFactory<OT extends DIObject, MT extends BaseEvent>
    extends ObjectFactoryComponent<OT, MT> {
  @override
  void onGenerateObject(MT message) {
    final newObject = facotry(message);
    objects[message.objectId] = newObject;
    gameRef.world.add(newObject);
  }

  @override
  void onRemoveObject(MT message) {
    final object = objects[message.objectId];
    if (object == null) return;
    objects.remove(message.objectId);

    // 만약 사라지는 애니메이션 등이 있다면
    // 애니메이션 종료 후 실행할 콜백으로 넘길 수 있다.
    object.removeObject();
    // object.removeFromParent();
  }
}
