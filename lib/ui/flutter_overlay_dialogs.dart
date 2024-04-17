import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/widgets/ranking_table.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;

abstract class FlutterOverlayDialog extends ValueRoute<bool>
    with HasGameRef<DustyIslandGame> {
  FlutterOverlayDialog() : super(value: false, transparent: false);

  Widget _contendsBuilder();

  @override
  String get name => throw UnimplementedError('다이얼로그는 name이 필요합니다.');

  @override
  Component build() {
    gameRef.overlays.addEntry(name, _overlayBuilder);
    return Component();
  }

  @override
  void onPush(Route? previousRoute) {
    final didAdd = game.overlays.add(name);
    assert(didAdd, 'An overlay $name was already added before');
  }

  @override
  void didPop(Route nextRoute) {
    final didRemove = game.overlays.remove(name);
    assert(didRemove, 'An overlay $name was already removed');
    super.didPop(nextRoute);
  }

  Widget _overlayBuilder(BuildContext context, Game game) {
    return GestureDetector(
      onTap: () => gameRef.rootRouter.pop(),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: GestureDetector(
            onTap: () {}, // 다이얼로그 UI 바깥 부분을 터치했을 때만 이벤트를 잡기 위한 트릭
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _contendsBuilder(),
            ),
          ),
        ),
      ),
    );
  }
}

class GameCloseDialog extends FlutterOverlayDialog {
  @override
  String get name => 'close-dialog';

  @override
  Widget _contendsBuilder() {
    return Column(
      children: [
        // Expanded(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: RankingTable(
        //             rankingList: gameRef.playScene.rankingList ?? [],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Thank You',
              style: TextStyle(
                fontSize: 56,
                fontFamily: 'ONEMobilePOP',
                color: Colors.white,
                decoration: TextDecoration.none,
                shadows: [
                  Shadow(
                      // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.black),
                  Shadow(
                      // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.black),
                  Shadow(
                      // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.black),
                  Shadow(
                      // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: Colors.black),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size(120, 22),
                ),
                onPressed: () => completeWith(true),
                child: const Text(
                  'regame',
                  style: TextStyle(
                    fontFamily: 'ONEMobilePOP',
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size(120, 22),
                ),
                onPressed: () => completeWith(false),
                child: const Text(
                  'exit',
                  style: TextStyle(
                    fontFamily: 'ONEMobilePOP',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RankingDialog extends FlutterOverlayDialog {
  @override
  String get name => 'ranking-dialog';

  @override
  Widget _contendsBuilder() {
    return RankingTable(rankingList: gameRef.playWorld!.rankingList ?? []);
  }
}
