
import 'package:floor/floor.dart';

// BlockEntity represents the block data, including the villageList encoded as JSON
@Entity(tableName: 'blocks')
class BlockEntity {
    @PrimaryKey(autoGenerate: true)
    final int? id;

  final String blockName;
  final String blockId;
  final String villageList;
  final String type ;

  BlockEntity({
    this.id,
    required this.blockName,
    required this.blockId,
    required this.villageList,
    required this.type
  });

}
