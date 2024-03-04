import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;

class TempRankingData {
  final int id;
  final int score;
  final int kill;
  final int death;

  const TempRankingData(
    this.id,
    this.score,
    this.kill,
    this.death,
  );
}

class GameCloseDialog extends ValueRoute<bool>
    with HasGameRef<DustyIslandGame> {
  GameCloseDialog() : super(value: false, transparent: false);

  @override
  String get name => 'close-dialog';

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
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.amber.withOpacity(0.5),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildRakingTable(),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => completeWith(true),
                    child: const Text('다시 시작'),
                  ),
                  FilledButton(
                    onPressed: () => completeWith(false),
                    child: const Text('나가기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataTable _buildRakingTable() {
    return DataTable(
      columns: const [
        // TODO
        // enum 등 이용하기
        DataColumn(label: Text('아이디')),
        DataColumn(label: Text('킬')),
        DataColumn(label: Text('데스')),
        DataColumn(label: Text('점수')),
      ],
      rows: gameRef.playScene.rankingList!
          .map((data) => DataRow(cells: [
                DataCell(Text('${data.id}')),
                DataCell(Text('${data.kill}')),
                DataCell(Text('${data.death}')),
                DataCell(Text('${data.score}')),
              ]))
          .toList(),
    );
  }
}
