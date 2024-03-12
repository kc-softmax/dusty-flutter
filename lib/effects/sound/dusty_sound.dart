import 'package:flame_audio/flame_audio.dart';

class DustySoundPool {
  static final files = [
    'background_intro.mp3',
    'background_playing.mp3',
    'bang.mp3',
    'boat_wave.mp3',
    'crab_scream.mp3',
    'damaged_bomb.mp3',
    'electric_zap.mp3',
    'explosion.mp3',
    'extinguish.mp3',
    'fire.mp3',
    'hit_item.mp3',
    'launch_small.mp3',
    'lockon.mp3',
    'moaning.mp3',
    'punch.mp3',
    'scream.mp3',
    'shield_on.mp3',
    'shield_success.mp3',
    'shot_missaile.mp3',
    'sucking.mp3',
  ];

  bool isInit;

  DustySoundPool._(this.isInit);

  static final DustySoundPool instance = DustySoundPool._(false);

  init() {
    FlameAudio.audioCache = AudioCache(prefix: 'assets/sounds/');
    isInit = true;
  }

  load() async {
    assert(isInit, 'You Need to call DustySound.init()');
    await FlameAudio.audioCache.loadAll(files);
  }

  // bgms
  bgmOnGamePlaying() =>
      FlameAudio.bgm.play('background_playing.mp3', volume: 0.2);
  bgmOnGameLobby() => FlameAudio.bgm.play('background_intro.mp3');

  // loop
  // 반복재생이 필요한 사운드들
  // 추후에 상태에 따라 stop이 되어야한다.
  Future<AudioPlayer> loopOnFinishingFire() => FlameAudio.loop('explosion.mp3');
  Future<AudioPlayer> loopOnFinishingLightning() =>
      FlameAudio.loop('explosion.mp3');
  Future<AudioPlayer> loopOnBoost() => FlameAudio.loop('explosion.mp3');
  Future<AudioPlayer> loopOnShield() => FlameAudio.loop('explosion.mp3');
  Future<AudioPlayer> loopOnLockOn() => FlameAudio.loop('lockon.mp3');

  // effects
  // 단발성 사운드들
  Future<AudioPlayer> effectOnActivateFireFinishing({double volume = 1.0}) =>
      FlameAudio.play('explosion.mp3', volume: volume);
  Future<AudioPlayer> effectOnActivateLightningFinishing(
          {double volume = 1.0}) =>
      FlameAudio.play('explosion.mp3', volume: volume);
  Future<AudioPlayer> effectOnActiveSkil({double volume = 1.0}) =>
      FlameAudio.play('explosion.mp3', volume: volume);
  Future<AudioPlayer> effectOnSpecialSkil({double volume = 1.0}) =>
      FlameAudio.play('explosion.mp3', volume: volume);
  Future<AudioPlayer> effectOnSecondarySpecialSkil({double volume = 1.0}) =>
      FlameAudio.play('explosion.mp3', volume: volume);
  Future<AudioPlayer> effectOnDeath({double volume = 1.0}) =>
      FlameAudio.play('crab_scream.mp3', volume: volume);
  Future<AudioPlayer> effectOnPlayerDeath({double volume = 1.0}) =>
      FlameAudio.play('scream.mp3', volume: volume);
}
