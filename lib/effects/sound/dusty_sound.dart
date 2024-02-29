import 'package:flame_audio/flame_audio.dart';

class DustySound {
  static final files = [
    'boost.mp3',
    'check.mp3',
    'click.mp3',
    'death.mp3',
    'explosion.mp3',
    'food.mp3',
    'game_over.mp3',
    'kill.mp3',
    'magnet.mp3',
    'opening.mp3',
    'ping.mp3',
    'player_death.mp3',
    'playing.mp3',
    'select.mp3',
    'timer.mp3',
    'unselect.mp3',
    'user_death.mp3',
  ];

  bool isInit;

  DustySound._(this.isInit);

  static final DustySound instance = DustySound._(false);

  init() {
    FlameAudio.audioCache = AudioCache(prefix: 'assets/sounds/');
    isInit = true;
  }

  load() async {
    assert(isInit, 'You Need to call DustySound.init()');
    await FlameAudio.audioCache.loadAll(files);
  }

  // bgms
  bgmOnGamePlaying() => FlameAudio.bgm.play('playing.mp3');
  bgmOnGameOver() => FlameAudio.bgm.play('playing.mp3');
  bgmOnGameLobby() => FlameAudio.bgm.play('playing.mp3');

  // effects
  effectOnBoost() => FlameAudio.bgm.play('playing.mp3');
  effectOnExplosion() => FlameAudio.bgm.play('playing.mp3');
  effectOnFarming() => FlameAudio.bgm.play('playing.mp3');
  effectOnKill() => FlameAudio.bgm.play('playing.mp3');
  effectOnDeath() => FlameAudio.bgm.play('playing.mp3');
  effectOnPlayerDeath() => FlameAudio.bgm.play('playing.mp3');
}
