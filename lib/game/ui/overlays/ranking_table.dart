import 'package:dusty_flutter/arbiter/live_service/system_message.dart';
import 'package:dusty_flutter/extensions/string.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flutter/material.dart';

class RankingTable extends StatelessWidget {
  final List<GamePlayerRecord> rankingList;

  const RankingTable({super.key, required this.rankingList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: RankingTableColumnsData.values
          .map((column) => DataColumn(label: Text(column.label)))
          .toList(),
      rows: rankingList.map((recordData) {
        final recordJson = recordData.toJson();
        final row = RankingTableColumnsData.values
            .map((column) => DataCell(
                Text(recordJson[column.name.toSnakeCase()].toString())))
            .toList();
        return DataRow(cells: row);
      }).toList(),
    );
  }
}
