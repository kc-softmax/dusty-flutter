import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

enum SkillButtonSize {
  normal(88.0, 64.0),
  big(110.0, 80.0);

  final double size;
  final double iconSize;
  const SkillButtonSize(this.size, this.iconSize);
}

class SkillButton extends AdvancedButtonComponent
    with HasGameRef<DustyIslandGame> {
  int _count = 0;
  String _skillIcon = 'skill_icon';
  late final RectangleComponent _containerComponent;
  late final SpriteComponent _shadowComponent;
  late final SpriteComponent _borderComponent;
  late final SpriteComponent _skillComponent;
  late final SpriteComponent? _skillCounterComponent;
  late final RectangleComponent _coolTimeCurtonComponent;
  late final RectangleComponent _dimComponent;

  final SkillButtonSize skillButtonSize;
  final double baseSize = SkillButtonSize.normal.size;
  final bool showCount;
  final double cooltime;
  final Function? onClick;

  SkillButton({
    this.skillButtonSize = SkillButtonSize.normal,
    this.showCount = false,
    this.cooltime = 0,
    this.onClick,
  }) {
    super.onPressed = () {
      if (count < 1) return;
      count -= 1;
      _coolTimeCurtonComponent.add(SizeEffect.to(
        Vector2(skillButtonSize.iconSize, skillButtonSize.iconSize),
        EffectController(duration: cooltime, reverseDuration: 0.5),
        onComplete: () {
          isDisabled = false;
        },
      ));
      isDisabled = true;
      onClick?.call();
    };
  }

  int get count => _count;
  set count(int value) {
    if (_count == 0 && value > 0) {
      _borderComponent.sprite = _getActiveBorder();
      _dimComponent.setOpacity(0);
    } else if (_count > 0 && value == 0) {
      _borderComponent.sprite = _getDeactiveBorder();
      _dimComponent.setOpacity(0.5);
    }
    _count = value;
  }

  String get skillIcon => _skillIcon;
  set skillIcon(String value) {
    _skillIcon = value;
    _skillComponent.sprite = _getSkilIcon();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _setButtonSkin();
    count = 1;
  }

  void _setButtonSkin() {
    _containerComponent = RectangleComponent.fromRect(
        Rect.fromLTWH(0, 0, skillButtonSize.size, skillButtonSize.size))
      ..setColor(Colors.transparent);

    _setShadow(_containerComponent);
    _setSkill(_containerComponent);
    _setCurton(_containerComponent);
    _setDim(_containerComponent);
    _setBorder(_containerComponent);
    _setSkillCounter(_containerComponent);

    defaultSkin = _containerComponent;
    disabledSkin = _containerComponent;
  }

  void _setShadow(RectangleComponent container) {
    final containerRect = container.toRect();
    container.add(_shadowComponent = SpriteComponent(sprite: _getShadow())
      ..setByRect(
        Rect.fromLTWH(
          containerRect.left,
          containerRect.top,
          containerRect.width,
          containerRect.height,
        ),
      ));
  }

  void _setBorder(RectangleComponent container, {bool isActive = false}) {
    final borderSprite = isActive ? _getActiveBorder() : _getDeactiveBorder();
    container.add(_borderComponent = SpriteComponent(sprite: borderSprite)
      ..setByRect(Rect.fromLTWH(
        0,
        0,
        container.width - 3.5,
        container.height - 3.5,
      )));
  }

  void _setSkill(RectangleComponent container) {
    container.add(_skillComponent = SpriteComponent(sprite: _getSkilIcon())
      ..setByRect(Rect.fromCenter(
        center: container.center.toOffset(),
        width: skillButtonSize.iconSize,
        height: skillButtonSize.iconSize,
      )));
  }

  void _setSkillCounter(RectangleComponent container) {
    if (!showCount) {
      _skillCounterComponent = null;
      return;
    }
    container.add(
        _skillCounterComponent = SpriteComponent(sprite: _getSkillCounter())
          ..size = Vector2(37, 22)
          ..position =
              Vector2(container.toRect().right - 37, container.height - 22));
  }

  void _setCurton(RectangleComponent container) {
    container.add(
        _coolTimeCurtonComponent = RectangleComponent.fromRect(Rect.fromLTWH(
      _skillComponent.x,
      _skillComponent.y + _skillComponent.size.y,
      _skillComponent.size.x,
      0,
    ))
          ..flipVertically()
          ..setColor(curtonColor.withOpacity(0.5)));
  }

  void _setDim(RectangleComponent container) {
    container.add(_dimComponent = RectangleComponent.fromRect(Rect.fromLTWH(
      _skillComponent.x - 2,
      _skillComponent.y - 2,
      _skillComponent.width,
      _skillComponent.height,
    ))
      ..setColor(dimColor.withOpacity(0.5)));
  }

  Sprite _getActiveBorder() =>
      gameRef.atlas.findSpriteByName('active_skill_border') as Sprite;

  Sprite _getDeactiveBorder() =>
      gameRef.atlas.findSpriteByName('deactive_skill_border') as Sprite;

  Sprite _getShadow() =>
      gameRef.atlas.findSpriteByName('skill_bt_shadow') as Sprite;

  Sprite _getSkillCounter() =>
      gameRef.atlas.findSpriteByName('skill_counter_box') as Sprite;

  Sprite _getSkilIcon() => gameRef.atlas.findSpriteByName(_skillIcon) as Sprite;
}
